---
title: "Networking Fundamentals"
date: 2026-03-23T19:53:33+05:30
draft: false
author: "Azlan Raban"
tags:
  - Networking
  - Fundamentals
  - example
image: /images/networking-computers.png
description: "A practical guide to the networking concepts every software engineer needs to know to debug, deploy, and scale applications."
toc: true
---

## Networking Fundamentals: A Developer's Perspective

When you first start out in software engineering, networking can feel like dark magic. You write your code, push it to a server, and somehow it just "works" over the internet. But once you spend a couple of years building, deploying, and—most importantly—debugging distributed applications, you realize that a solid grasp of networking isn't just for sysadmins; it's a critical developer skill. 

Whether you are trying to figure out why your Docker containers can't talk to each other, configuring a reverse proxy, or setting up a CI/CD pipeline, understanding the foundational layers of networking saves hours of headaches. 

Here is a practical breakdown of the networking fundamentals I rely on day-to-day.

### 1. The OSI Model (The Pragmatic Version)

You've probably seen the Open Systems Interconnection (OSI) model. It's a conceptual framework that divides networking into seven layers. While you don't need to memorize the exact packet structure of every layer, understanding the stack helps you isolate bugs. 

As a software engineer, you will spend 90% of your time in these three layers:
* **Layer 3 (Network):** This is where IP addresses live. It handles routing data between different networks. If your server can't reach an external API, it might be a Layer 3 routing issue.
* **Layer 4 (Transport):** This is the domain of TCP and UDP. It handles port numbers and ensures data actually gets where it's going. 
* **Layer 7 (Application):** This is where HTTP, HTTPS, DNS, and WebSockets operate. It's the layer your application code interacts with directly.

### 2. IP Addresses, Subnets, and Localhost

Every device on a network needs an identifier. 

* **IPv4 vs. IPv6:** IPv4 addresses (like `192.168.1.5`) are still the most common you'll deal with internally, though IPv6 is the modern standard used to solve the shortage of available addresses.
* **Public vs. Private IPs:** Public IPs are routable on the open internet. Private IPs (like those starting with `10.x.x.x` or `192.168.x.x`) are only valid within your local network or Virtual Private Cloud (VPC). 
* **Localhost (`127.0.0.1`):** The loopback address. When you tell your app to bind to `localhost`, it is strictly accessible only from inside that specific machine (or container). If you want an app to be accessible from outside, you usually bind it to `0.0.0.0`, telling it to listen on all available network interfaces.

### 3. TCP vs. UDP: How We Talk

At Layer 4, data is chopped up and transported. The two main protocols serve very different use cases:

* **TCP (Transmission Control Protocol):** The reliable workhorse. TCP establishes a connection (the famous "three-way handshake") and guarantees that packets arrive in order and without errors. If a packet is lost, it requests it again. We use TCP for HTTP, database connections, and SSH. 
* **UDP (User Datagram Protocol):** The "fire and forget" protocol. It sends data without verifying if the other side received it. It's much faster than TCP because there's no overhead, making it ideal for video streaming, gaming, or high-volume metrics and logging (like sending telemetry to a monitoring stack).

### 4. Ports: The Apartment Numbers

If an IP address is a building's street address, a port is the specific apartment number. A server only has one IP, but it has 65,535 ports. 
* **Port 80:** HTTP (Unencrypted web traffic)
* **Port 443:** HTTPS (Encrypted web traffic)
* **Port 22:** SSH (Secure shell access)
* **Port 5432:** Default for PostgreSQL

When you run multiple services on the same machine, they must bind to different ports to avoid conflicts.

### 5. DNS: Because It's Always DNS

The Domain Name System (DNS) translates human-readable domain names (like `google.com`) into IP addresses. 

When a service goes down, there is a running joke in the industry: *"It's not DNS. There's no way it's DNS. It was DNS."* Understanding how A Records (pointing a domain to an IPv4 address), CNAMEs (pointing a domain to another domain), and TXT records work is essential for configuring custom domains for your deployments or verifying SSL certificates.

### 6. The Container Context (Docker & Kubernetes)

Modern infrastructure relies heavily on containerization, which introduces its own networking layer. 

When you spin up a Docker container, it doesn't automatically share your host machine's network. It gets its own isolated network namespace. 
* **Bridge Networks:** The default in Docker. Containers on the same bridge can talk to each other using internal IP addresses or container names (thanks to Docker's internal DNS), but they are isolated from the outside world unless you explicitly map a port (e.g., `-p 8080:80`).
* **Kubernetes Networking:** K8s takes this a step further. Every Pod gets its own IP address, and you use Services to expose those Pods, load balance traffic, and maintain stable internal endpoints even as individual Pods die and restart. 

### Final Thoughts

Networking isn't just about cables and routers anymore; it's defined in software. By mastering these fundamentals, you bridge the gap between writing code and actually operating reliable, scalable systems in production.