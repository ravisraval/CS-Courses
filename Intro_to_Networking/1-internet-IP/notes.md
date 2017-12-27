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

### Life of a Packet

##### TCP byte stream
 - most web traffic happens over transport control protocol
 - typically, a client and a server
 - server listens for connection requests
 - client issues connection request, which server responds to
 - this exchange takes three messages, called the **3-way handshake**
      1. client sends synchronized message, "SYN"
      2. server responds with a synchronized message that acknowledges the client's message, "SYN/ACK"
      3. client responds by acknowledging server's response, "ACK".

- The network layer doesn't see a difference between packets going to different applications on the same computer, so to open a TCP stream to another program, we need two addresses:
  - IP address - network uses to send packets to the right computer
  - TCP port - tells the computer which application to deliver the data to
    - web servers often run on port 80
- Routers themselves have IP addresses - eg if you want to log in to the router itself

#### Router Forwarding Table
  - contains ip addresses patterns and corresponding links
  - Router indexes into its forwarding table and checks which pattern BEST, or most SPECIFICALLY, matches pattern
  - default route is the least specific - it matches any IP address
    - especially useful in edge networks, ie, sending out to internet vs another router / host within the current network

Wireshark allows you to see packets
Traceroute shows all the hops a packet takes

### Packet Switching
   - Independently for each arriving packet, pick its outgoing link. If the link is free, send it. Else, hold the packet for later.

   - **Self-routing / source routing**
      - Each packet contains an explicit route, specifying the ids of each packet switch along the way
      - generally doesn't happen - big security issues
    - nowadays, internet places a small amount of state in each switch, telling it which hop to next send packets to

##### consequences of packet switching
  - switch can make individual, local decisions without knowing anything other than the destination address
  - switch can efficiently share links between two hosts
    - wireless router in a home

##### no per-flow state required
  - **flow**: a collection of datagrams belonging to the same end-to-end communication, e.g. TCP connection
    - for instance, one skype call
  - packet swithes don't need state for each flow - each packet is self-contained
  - no per-flow state to be added/removed from each switch
  - no per-flow state to be stored
  - no per-flow state to be changed upon failure

##### Efficient sharing of links
  - Data traffic is bursty
    - packet switching allows flows to use all available link capacity
    - packet switching allows flows to share link capacity
  - this is called **statistical multiplexing**

### Summary of packet switching:
  - a packet is a self-contained unit of data that carries all the information needed for it to reach its destination
  - packet switch - Independently for each arriving packet, pick its outgoing link. If the link is free, send it. Else, hold the packet for later.

## Layering
  - the name we give to the organization of a system into a number of separate functional components, or layers.
  - layers are hierarchical and communicate only with layers directly above and below
  - each layer provides a well-defined service to the layer above, using the services provided by layers below and its own private processing

#### Layering in a computer system
  1. as programmers, we communicate with the compiler, the link below
  2. the compiler is a self-contained, functional component that is in charge of lexical analysis, parsing our code, preprocessing declarations, and then code generation and optimization.
  3. the compiler passes object code to the linker
  4. the linker links together compiled object files and libraries and generates an executable file, passing it to the CPU
  5. the CPU, real or virtual, then executes the code.

  - many benefits to layering:
     - breaks down overall problem of writing programs that execute on hardware into modules, each with a well defined role and providing a well defined service to the layer above
     - clear separation of concerns, so layers don't have to worry about doing the job of the other layers.
     - each layer can therefore be improved/upgraded/replaced without interfering with other layers

  - Sometimes you do have to break layer boundaries, but at a great cost, as you lose the benefits of layering.

###### 6 main reasons for layering
  1. Smaller, more manageable modules
  2. Well defined service
  3. Reuse
  4. Separation of concerns
  5. Continuous improvement
  6. Peer-to-peer communications
     - each layer only has to worry about its corresponding layer - top level applications don't have to concern themselves with the other 3 layers in the 4 layer system

## Encapsulation
  - principle by which you organize information in packets so that you can maintain layers
  - a TCP segment is inside an IP packet which is inside an Ethernet frame
  - each protocol layer has headers, then payload/data, then footers.
    - eg. IP packet's payload is a full TCP segment

  - A VPN is an example of lots of encapsulation. From outside to inside:
    - ethernet link frame
    - IP network packet
    - TCP transport segment
    - a secured TLS presentation message
    - IP network packet
    - TCP transport segment
    - HTTP web application payload

  - encapsulation is how layering manifests in data
  - simplify layer implementation

## Memory, byte order, and packet formats
  - computers need to agree on what fields messages have, and how the fields and arranged and formatted
  - when a computer sends a message, it must create a copy of it in memory, which then passes to the networking card
  - similarly, when a computer receives a message, the networking card puts that message in memory, which the software can then access

#### Endianness
   - How should a computer represent a multibyte value?
   - To represent the number 1,024, which is 0x0400 in hexidecimal.
   - This value requires 16 bits, or 2 bytes.
   - Which byte comes first? 0x00 or 0x04?

   - **Little Endian** places the least significant byte at the lowest address in memory
   - **Big Endian** places the most significant byte at the lowest address

#### Network Byte order
  - different processors use different Endianness
     - little endian x86
     - big endian: ARM (iPhone)
  - internet is big Endian
  - important to make sure you're properly translating
