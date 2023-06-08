# An in depth overview of HTTP/2
## Introduction
HTTP/2 is a new protocol, intended as a higher performance alternative to HTTP/1.1. It introduces several new features, while remaining semantically compatible.

## Key Features
HTTP/2 has the following key features compared to HTTP/1.1:

- Binary Protocol
HTTP/2 is a binary protocol. This means that it is much more efficient on the wire, however as a result it is no longer human readable without using tools to decode the protocol.

0 Multiplexing
HTTP/2 supports multiplexing several streams over a single connection. This means that a client can send multiple requests on the same connection, and the server can respond in whatever order the responses become available.

- Header Compression
HTTP requests and responses generally include a large number of redundant headers. HTTP/2 uses HPACK header compression to greatly compress headers.

- Server Push
Server push allows a server to send additional cacheable resources to the client that the client has not explicitly asked for. The allows the server to anticipate the resources the client will request next and send them eagerly, which saves a round trip.

## Connection Establishment
The first part of any usage of HTTP/2 is connection establishment. It would not be practical to allocate a new port just for HTTP/2 for various reasons, so instead the protocol defines 3 different methods of connection that allow the existing HTTP and HTTPS ports to be re-used.

- ALPN based connection for https:// URIs

- HTTP upgrade based connection http:// URIs

- Connection via prior knowledge for hosts which are known to support HTTP/2

A detailed explanation of the three is given below. Once the initial connection has been established both the client and server send a connection preface, after which the connection is established.

## HTTP/2 Connection methods
- ALPN based connection for https:// URIs
ALPN stands for Application Layer Protocol Negotiation, and is a TLS extension that allows a client to negotiate the next protocol to use after the TLS handshake is complete. If either the client or the server does not support ALPN, then it will be ignored, and HTTP/1.1 will be used instead.

When the client connects to the server it sends a list of supported protocols. The server will then decide on the next
protocol to use and send this back in its response. If the server decides to use HTTP/2 it will send pack 'h2' as the
selected protocol, and HTTP/2 will be used for the connection.
HTTP upgrade based connection http:// URIs
When using this method a client sends a HTTP/1.1 request as normal, however it includes an Upgrade: h2c header that indicates to the server that it wishes to upgrade the connection to HTTP/2.

If the server does not understand HTTP/2 or for whatever reason does not wish to use it, it will simply ignore the upgrade
request and send a normal HTTP/1.1 response. If the server does decide to upgrade to HTTP/2 then it sends back a HTTP/1.1
101 (switching protocols) response, and then after connection establishment has completed sends the response to the
original request using HTTP/2.
A client connecting using this method must also include a `HTTP2-Settings` header field, which contains a base 64
encoded HTTP/2 settings frame (more on this later).
(NOTE: Firefox and Chrome have both publicly stated that they are not going to support this method, so it remains to be
 seen if this method will see much real world use).
Connection via prior knowledge for hosts which are known to support HTTP/2
If it is known that a given host supports HTTP/2 then a client can connect directly by sending a HTTP/2 connection preface. This connection preface is covered in detail below, but it essentially follows the format of HTTP request with PRI as the request method and HTTP/2.0 as the protocol, which allows HTTP/1.1 servers to parse it normally. It is not expected that this method will be used on the open internet, however it has its uses (e.g. the Undertow reverse proxy implementation will use it to connect to backend server it knows support HTTP/2).

### HTTP/2 connection preface
Once the initial connection has been established both the client and the server must send a connection preface. The client sends the string `PRI * HTTP/2.0\r\n\r\nSM\r\n\r\n`, followed by HTTP/2 `SETTINGS` frame, which may be empty.

The server must send a `SETTINGS` frame (which may be empty).

Once the connection preface has been exchanged the connection is considered established, and the endpoints can use it to communicate.

## Wire Format
This post will not go into a in-depth discussion of the wire format, instead we will just give an overview of the basic concepts (if you more details I highly recommend going directly to the specification).

HTTP/2 is a framed protocol. All data that is send is part of a frame, which consists of a frame header, followed by some frame data, the format of which depends on the frame type. The maximum size of a frame is `2^24-1` (16,777,215) octets.

A frame header contains the following information:

- The frame length

- The frame type

- Flags

- Stream identifier

The specification defines the following frame types:

- DATA
Carries the data in a request or response.

- HEADERS
Used to open a stream (i.e. start a request or response), it contains the headers associated with the request or response

- PRIORITY
Used to set the priority of a stream

- RST_STREAM
Forcibly terminates a stream, this is only used if one endpoint decides to cancel a stream, it is not used for normal stream termination

- SETTINGS
Establishes connection settings for the HTTP/2 connection

- PUSH_PROMISE
Sent by the server to push a response to the client

- PING
Sends a ping to the remote endpoint, which must respond with a ping of its own

- GOAWAY
Sent when an endpoint is going to close the connection

- WINDOW_UPDATE
Updates the flow control window

- CONTINUATION
Used to send additional headers if the headers are too large to fit in a single HEADERS frame

It is also possible for extensions to define new frame types. An endpoint that does not understand a frame type must simply discard the frame, rather than treating it as an error.

## Multiplexing
In HTTP/1.1 requests are essentially processed one at a time. A client sends a request to a server, which generates a response, and once the client has received the response it can send another request to the server. This is not great from a performance point of view. Because only one resource can be requested at a time a single slow resource can delay the rendering of a page. It also does not allow for multiple resources to be generated at the same time.

As a result there are lots of workaround that are used on both the server and browser side to improve performance, including:

- Browsers opening multiple connections per host, so multiple resources can requested at once

- Spriting, where a page with multiple images merges them into a single image, and CSS is used to control the part of the image that is displayed

- Domain sharding, where resources are served from different subdomains, which allows the browser to open more connections as the browsers internal connection limit is applied per domain

- HTTP pipelining, where requests are send before responses are relieved, so the server can begin processing them immediately once the current response is done

HTTP/2 avoids these issues, through the use of multiplexing. This allows multiple requests to be active at once, and the responses can be interleaved on the wire as they become available.

This is done through the concept of streams, in HTTP/2 every request/response pair is mapped to a stream. Each stream is given a unique id. Streams started by the client (most streams) must use odd numbers for the stream identifier, while streams initiated by the server (server push) use even identifiers. Streams are initiated by a HEADERS frame from the client, or a PUSH_PROMISE frame from the server. All HTTP/2 frames include a stream identifier in the header, which allows an endpoint to determine which request the frame belongs to. By default there is no limit to the number of concurrent streams that can be active on a connection, although the server can impose a limit using a SETTINGS frame to limit the amount of server resources a single client can consume.

## Request/Response Overview
At its core HTTP/2 is still a request oriented protocol. A client sends the server a request, the server generates a response and sends it back (server push is obviously an exception to this). This means that it maps cleanly to HTTP/1.1 semantics, so in many cases the application code that is processing a request does not need to know which version of HTTP the wire protocol is using.

A request is started by a client sending a HEADERS frame to open a stream. As you would expect from the name this contains normal HTTP request headers, however it also contains the following pseudo headers:

- :method
The request method

- :path
The request path

- :scheme
The request scheme. Usually either http or https

- :authority
Similar to the HTTP/1.1 Host: header, this contains the authority portion of the target URI (e.g. http://example.com)

These pseudo headers must be present and the first headers in the frame. After this the HEADERS frame can contain any number of request headers. If the number of request headers exceeds the maximum frame size then the client can immediately send CONTINUATION frames with additional headers. The last frame containing headers will have the END_HEADERS flag set, which tells the remote endpoint that there is no more headers.

The request can also contain data (e.g. POST requests). If the request has no data the initial HEADERS frame will have the END_STREAM flag set, which tells the server there is no data. Otherwise the server will expect the client to send any number of DATA frames, with the END_STREAM flag set on the last one.

When the server is ready to send a response sequence of frames is similar to when the client sends a request, a single HEADERS frame, followed by optional CONTINUATION frames if the headers do not fit in a single frame, followed by DATA frames for the entity body, however in this case the only pseudo header field is :status, which carries the response status code.

Note that because of the framed structure of HTTP/2 it is no longer necessary (in fact explicitly forbidden) to use the chunked transfer encoding that HTTP/1.1 uses for entities of unknown lengths. If the content length is known it is still recommended to send it in a Content-Length header, even though it is no longer required for the client to know when the request is done it makes for a more user friendly experience (as if this is not present it is not possible for a client to display download progress).

## HPACK
HTTP/2 introduces a form of header compression called HPACK. HPACK allows for very efficient header compression, without being vulnerable to compression related attacks such as CRIME. HPACK provides the following:

The ability to encode large headers using a fixed Huffman encoding

The ability to encode commonly used headers as a variable length integer, rather than re-sending the whole header each time

All headers sent via HTTP/2 (in HEADERS, CONTINUATION and PUSH_PROMISE frames) are sent in the HPACK format.

HPACK works by having both endpoints maintain a copy of a header table (the dynamic table). When an endpoint sends a header to the remote endpoint it can instruct the remote endpoint to store it in its dynamic table. If the endpoint needs to send the same header again it can just send its index in the dynamic table, instead of sending the whole header. The size of the dynamic table is limited to 4k by default, however larger or smaller limits can be set using a SETTINGS frame.

As many requests and responses will contain the same headers, this technique is very effective, as after the first request most headers will be represented as an integer index into the dynamic or static table.

HPACK also defines a static table which is a pre defined table of commonly used headers, so HPACK will provide some compression even before the dynamic table is populated.

HPACK also allows header names and values to be encoded via a fixed Huffman encoding. Because this encoding uses a fixed encoding table, it is not vulnerable to compression based attacks such as CRIME.

## Server Push
First introduced in the SPDY protocol, server push allows a server to send unsolicited request+response pairs to a client. Generally this will be used to immediately begin sending resources that a server expects a client based on the current request. For example if a client requests /index.html, and the server knows that /index.html contains a reference to /logo.png the server might decide to immediately push logo.png rather than waiting for the client to request it.

To push a response to the client the server opens a stream using a PUSH_PROMISE frame, which contains the complete set of request header fields that the server attributes to the request (this includes pseudo headers, such as :path, which let the client know exactly which resource is being pushed). A PUSH_PROMISE frame must be associated with an existing client request, so the client knows which request caused the server to initiate the push. After the PUSH_PROMISE frame has been send the server may begin sending HEADERS followed by DATA frames, as it would for a normal response.

Pushed resources must be cacheable. In practice this means that pushed requests will generally be limited to GET requests with a response that contains headers that allow for caching.

If a server pushes a request for a resource that the client knows it does not need (for example it may already have the resource in its cache) the client can send a RST_STREAM frame to the server to cancel the pushed request.

Note that there is no foolproof way to know exactly what should be pushed, as there is know way to know exactly what a client has in its cache. Initiating a large number of pushes for resources that the client already has cached is obviously not ideal, as it can waste server resources and bandwidth (even if the client does RST_STREAM the pushed request, the server will may have already allocated resources to servicing the push request).

## Priority
Priority is a new concept that HTTP/2 introduces to allow a client to give priority preferences to particular streams. Priority is non binding, and a server is free to ignore it completely.

The priority mechanism is expressed in terms of stream dependencies and weights. A stream can be given a dependency on another stream, which tells the server that it should allocate resources to the identified stream instead of the dependent stream (conceptually all streams are considered to depend on another stream, streams with no explicit dependency depend on the virtual stream 0).

According to the spec a server should only allocate resources to a dependent stream if all its dependencies (and their dependencies) are either closed or it is not possible to make progress on them.

Dependent streams can also be given a weight, between 1 and 256, and resources should be allocated on a proportional basis. For example if stream A and B have a dependency on C, and A has a weighting of 1 and B has a weighting of 10 then B should receive 10 times amount of server resources as A.

Dependencies and weightings can be set at stream creation time, and modified afterwards with a PRIORITY frame.

Note that due to the complexity of implementing this on the server side it is unlikely that many implementations will be able to allocate resources and prioritise as the spec specifies. In general once a request has started being processed in most cases a server does not have control over how CPU and other resources (database connection etc) are processed. In practice servers will likely be able to prioritise frames from higher priority streams if multiple frames are ready at the same time, and if streams are being queued for execution processes higher priority streams over lower priority ones, but in general a client cannot rely on priority as being anything other than a suggestion.

Flow Control
HTTP/2 has the concept of a credit based flow control mechanism. Every stream, and the connection as a whole maintains a send window, which is the amount of data that the server is allowed to send on the stream/connection. Once this window is exhausted no more data can be sent, until the remote endpoint sends a WINDOW_UPDATE frame that increases the send window size. This additional flow control window is on top of the flow control already provided by TCP. The default window size is 65,535 bytes, however many implementation will increase this in the initial SETTINGS frame. Flow control only applies to DATA frames.

To understand why this is necessary consider a server handling a large POST request from a client. The server basically acts as an intermediary between the network and some web application, if the web application is slow to read this POST data, then as a server we only have two options:

Buffer a potentially unbounded amount of data
In this scenario the client keeps sending data, and we keep storing it in memory waiting for the web application to ask for it. This has the potential for a misbehaving or malicious client to make the server run out of memory.

Stop reading from the underlying socket
Once we have buffered a certain amount of data we could simply stop reading from the underlying socket until the end user application empties the buffer. Unfortunately this means that all other requests will also be blocked (head of line blocking), which negates a lot of the benefits of multiplexing.

Flow control allows us to limit the amount of data that is sent for any given stream, essentially allowing us to pause the stream until the web application actually starts reading data. If we don’t send WINDOW_UPDATE frames for a stream until the web application has actually consumed the data then we know that the maximum amount of data we will need to buffer per stream is equivalent to the window size (which we can control through a SETTINGS frame).

Without flow control an endpoint has no effective way of managing the amount of data it may need to buffer.

Something to note is that the flow control window can be different in each direction. For example a resource constrained server may set a small flow control window size to prevent the client from flooding it with a large amount of data, while the client may set a large flow control window for maximum performance. In this case the server can send a large amount of data before receiving a WINDOW_UPDATE, while the client will only be able to send a small amount.

Note that flow control should not be used as a priority mechanism (HTTP/2 already has the concept of stream priority for this). In particular a deadlock can result if a client stops sending WINDOW_UPDATE frames on a stream1 because it wants a server to prioritise stream2, and the server has decided not to allocate resources to stream2 until stream1 is complete.

Settings
The HTTP/2 settings frame is used to establish settings that are used to control each side of the connection. Each endpoint sends its own settings, which may be different which means the settings may be different for depending on the direction of communication (e.g. the maximum frame size can be different depending on if they are sent by the client or the server).

The specification defines the following settings:

SETTINGS_HEADER_TABLE_SIZE
The maximum allowed size of the HPACK header table. Defaults to 4,096.

SETTINGS_ENABLE_PUSH
A setting that is sent from the client to the server, if this is enabled then the server is allowed to push responses to the client, default to true.

SETTINGS_MAX_CONCURRENT_STREAMS
The maximum number of concurrent streams that can be opened, basically this corresponds to the number of requests that can be active at the same time. By default this is unlimited.

SETTINGS_INITIAL_WINDOW_SIZE
The initial window size that is used for flow control. Defaults to 65,535.

SETTINGS_MAX_FRAME_SIZE
The maximum allowed frame size that the remote endpoint is prepared to accept. Defaults to 16,384.

SETTINGS_MAX_HEADER_LIST_SIZE
This setting advises the remote endpoint of the maximum size of the header list the remote endpoint will accept. The default value is unlimited.


# Resources
[1] https://undertow.io/blog/2015/04/27/An-in-depth-overview-of-HTTP2.html