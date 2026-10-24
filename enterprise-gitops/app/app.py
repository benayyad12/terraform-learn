from http.server import BaseHTTPRequestHandler, HTTPServer
import os

class H(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/healthz":
            self.send_response(200); self.end_headers(); self.wfile.write(b"ok"); return
        self.send_response(200); self.end_headers()
        # DB_PASSWORD is injected by Vault Agent into /vault/secrets/db
        self.wfile.write(b"Hello from enterprise GitOps demo\n")

HTTPServer(("", 8080), H).serve_forever()
