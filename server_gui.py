import tkinter as tk
from tkinter.scrolledtext import ScrolledText
import subprocess
import threading
import os
import shutil

class TFSControllerApp:
    def __init__(self, master):
        self.master = master
        self.master.title("The Forgotten Server - Controle")
        self.master.geometry("800x550")

        button_style = {
            "bg": "#007acc",
            "fg": "white",
            "width": 20,
            "height": 2
        }

        self.compile_button = tk.Button(master, text="Compilar Servidor", command=self.compile_server, **button_style)
        self.compile_button.pack(pady=10)

        self.start_button = tk.Button(master, text="Iniciar Servidor", command=self.start_server, **button_style)
        self.start_button.pack(pady=5)

        self.stop_button = tk.Button(master, text="Parar Servidor", command=self.stop_server, state=tk.DISABLED, **button_style)
        self.stop_button.pack(pady=5)

        self.log_text = ScrolledText(master, state="disabled", height=25)
        self.log_text.pack(padx=10, pady=10, fill=tk.BOTH, expand=True)

        self.process = None
        self.thread = None

    def compile_server(self):
        def run_compile():
            self.write_log("Iniciando compilação em 'vc14'...\n")
            try:
                build_dir = os.path.join(os.getcwd(), "vc14")
                if not os.path.isdir(build_dir):
                    self.write_log("Diretório 'vc14' não encontrado.\n")
                    return

                make_cmd = ["make", "-j", str(os.cpu_count())]

                process = subprocess.Popen(
                    make_cmd,
                    cwd=build_dir,
                    stdout=subprocess.PIPE,
                    stderr=subprocess.STDOUT,
                    text=True
                )

                for line in process.stdout:
                    self.write_log(line)

                process.wait()
                if process.returncode != 0:
                    self.write_log("Compilação falhou.\n")
                    return

                self.write_log("Compilação concluída. Atualizando binário...\n")

                compiled_binary = os.path.join(build_dir, "theforgottenserver")
                target_binary = os.path.join(os.getcwd(), "theforgottenserver")

                if os.path.exists(target_binary):
                    os.remove(target_binary)
                    self.write_log("Binário antigo removido.\n")

                shutil.copy2(compiled_binary, target_binary)
                self.write_log("Novo binário copiado com sucesso!\n")

            except Exception as e:
                self.write_log(f"Erro na compilação: {e}\n")

        threading.Thread(target=run_compile, daemon=True).start()

    def start_server(self):
        if self.process is None:
            cmd = "./theforgottenserver" if os.name != "nt" else "theforgottenserver.exe"
            try:
                self.process = subprocess.Popen(
                    cmd,
                    stdout=subprocess.PIPE,
                    stderr=subprocess.STDOUT,
                    text=True,
                    bufsize=1,
                    shell=(os.name == "nt"),
                    preexec_fn=None
                )
                self.thread = threading.Thread(target=self.read_output)
                self.thread.daemon = True
                self.thread.start()

                self.start_button.config(state=tk.DISABLED)
                self.stop_button.config(state=tk.NORMAL)
                self.write_log("Servidor iniciado.\n")
            except Exception as e:
                self.write_log(f"Erro ao iniciar o servidor: {e}\n")

    def stop_server(self):
        self.write_log("Parando servidor com 'killall -9 theforgottenserver'...\n")
        try:
            subprocess.Popen(
                ["killall", "-9", "theforgottenserver"],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL
            )
            self.write_log("Comando de parada enviado.\n")
        except Exception as e:
            self.write_log(f"Erro ao tentar parar o servidor: {e}\n")

        self.process = None
        self.start_button.config(state=tk.NORMAL)
        self.stop_button.config(state=tk.DISABLED)

    def read_output(self):
        if self.process:
            for line in self.process.stdout:
                self.write_log(line)
            self.process = None
            self.start_button.config(state=tk.NORMAL)
            self.stop_button.config(state=tk.DISABLED)

    def write_log(self, message):
        self.log_text.config(state="normal")
        self.log_text.insert(tk.END, message)
        self.log_text.see(tk.END)
        self.log_text.config(state="disabled")

    def on_close(self):
        self.stop_server()
        self.master.destroy()

if __name__ == "__main__":
    root = tk.Tk()
    app = TFSControllerApp(root)
    root.protocol("WM_DELETE_WINDOW", app.on_close)
    root.mainloop()
