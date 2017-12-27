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

#### IP Service model
   Property | Behavior
   --- | :---:
  Datagram | Individually routed packets. Hop-by-hop routing.
  Unreliable | Packets may be dropped.
  Best effort | ..but only if necessary
  Connectionless | No per-flow state. Packets might be mis-sequenced.

  - Datagram Header
    - contains IPDA (destination address) and IPSA (source)
  - Each router has a forwarding table that it can index into using the IPDA
  - IP promises to only drop packets if needed, due to:
    - Packet queue in router is full, due to congestion
    - Faulty routing table in router, so it gets sent to the wrong place
  - IP doesn't inform if packets lost / dropped
  - Maintains no state
  - Connectionless - no end-to-end connection
    - the IP layer has no knowledge of what's going on around it

###### Why is the IP service so simple?
  - simple, dumb, minimal - faster, more streamlined, easier to maintain, need to be upgraded less often
  - **End-to-end principle**: where possible, implement features in the end hosts.
    - Easier to deal with software on hosts, vs baked into hardware
  - Allows a variety of reliable, or unreliable, services to be built on top
    - video chats don't want to retransmit lost data - no point
  - Works over any link layer - IP makes very few assumptions about the link layer below

###### Additional IP services given
  - creators tried to make it simple yet functional. here are a few additional services
  - **TTL field**, or time to live
    - hop count between routers
    - tries to prevent packets looping forever
  - Fragment packets that are too long
    - most links have limits on the sizes of packets they can carry
      - ethernet tops out at 1500 bytes
    - a router connecting two links can fragment a datagram, sending instructions to reassemble it
  - uses a **header checksum** to reduce chances of delivering datagram to wrong destination.
  - Allows for new versions of IP
    - IPv4, 32 bit addresses
    - IPv6, 128 bit addresses
  - Allows for new options to be added to header.
    - doesn't happen much
###### IPv4 Datagram
  - Header:
    - Source IP address
    - Destination IP address
    - Protocol ID
      - tells us what is inside the data, telling how to
      - allows destination source to demultiplex? arriving data, sending them to the correct code to process the packet
      - a '6' indicates TCP segment, so we can pass it to TCP code for proper parsing
      - there are over 144 values of protocol ID by the IANA
    - Version field
      - ipv4 or ipv6
    - Total Packet Length
      - up to 64 kb including header
    - TTL filed
      - each router decrements this
      - router destroys packet if ttl == 0
    - Flags & Fragment Offset
      - assist fragmentation
    - Type of service
      - hints router how important packet is
    - Header length
      - tells us how big the header is
      - some headers carry extra fields with extra info
    - Checksum
      - in case header is corrupted, we probably won't deliver the packet to the wrong destination
    
