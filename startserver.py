import http.server
class Server(http.server.ThreadingHTTPServer):
    request_queue_size = 128      # mặc định chỉ 5
    daemon_threads = True
class Handler(http.server.SimpleHTTPRequestHandler):
    protocol_version = "HTTP/1.1"  # keep-alive, bớt mở kết nối mới
Server(("0.0.0.0", 8080), Handler).serve_forever()