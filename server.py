import os
from http.server import HTTPServer, BaseHTTPRequestHandler

class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-Type', 'text/plain')
        self.end_headers()
        self.wfile.write(b"OK")

if __name__ == '__main__':
    port = int(os.environ.get('PORT', '8000'))
    server = HTTPServer(('0.0.0.0', port), RequestHandler)
    print("Fake server listening on port", port)
    server.serve_forever()
