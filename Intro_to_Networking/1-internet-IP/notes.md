##### Most network connections use this model: bidirectional, reliable byte stream connection.
  - one side reads while other writes
  - operates in both directions

### 4 layer internet model:
  1. Application
    - http, smtp, ssh, ftp...
  2. Transport
    - TCP, UDP, RTP
    - Guarantees correct, in-order delivery of data end-to-end
    - controls congestions
  3. Network
    - Only uses IP, internet protocol
    - IP attempts but doesn't promise to deliver datagrams
    - IP datagrams can be lost, delivered out of order, or corrupted
  4. Link
    - Ethernet, WiFi, DSL, 4g...
    - delivers data over a single link between an end host and a router,
      or between multiple routers
