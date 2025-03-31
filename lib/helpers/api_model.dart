// TODO() API model

import '../core/base/e_log.dart';

void main() {
  eLog('''
[2025-01-16 14:23:45] [INFO] [API Consumption]
--------------------------------------------------
Request:
  - Method:        POST
  - URL:           /api/v1/users
  - IP:            192.168.1.10
  - User-Agent:    Mozilla/5.0 (Windows NT 10.0; Win64; x64)
  - Auth User ID:  12345
  - Parameters:    {"name": "John Doe", "email": "john@example.com"}
  
Response:
  - Status Code:   201 Created
  - Time Taken:    150ms
  - Response Body: {"id": "67890", "name": "John Doe"}
  
Errors:
  - None

--------------------------------------------------

''');
}
