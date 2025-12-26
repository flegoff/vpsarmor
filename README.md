# [VPS Armor](https://vpsarmor.com)

Basic security hardening for Ubuntu LTS and Debian Stable servers.

More and more indie hackers are jumping into VPS from hosts like OVHCloud and Hetzner. That's fantastic! One should be able to host their own services and escape the merchants of complexity (to quote DHH).

But it's a scary world out there. If you are new to hosting your own services, you might quickly expose a DB over the internet or make other mistakes that all system administrators have made.

VPSArmor.com aims to offer a free and fast boilerplate for basic VPS system hygiene.

At this time, we encourage users to use a current and supported stable (Debian) or LTS (Ubuntu) version. We welcome patches and pull requests. One philosophy: KISS.

## Usage

```bash
curl -sSL https://raw.githubusercontent.com/flegoff/vpsarmor/main/armor.sh | sudo bash
```

## What it does

1. **Checks OS** - Verifies Ubuntu LTS (22.04, 24.04) or Debian Stable (Bookworm, Trixie)
2. **Updates packages** - Runs `apt update` and `apt dist-upgrade`
3. **Enables unattended-upgrades** - Automatic security patches
4. **Installs fail2ban** - Blocks brute-force attempts
5. **Configures UFW** - Firewall allowing only ports 22, 80, and 443

## Opening additional ports

```bash
ufw allow 3000/tcp
```

## Requirements

- Root access (or sudo)
- Ubuntu LTS or Debian Stable
- Fresh VPS recommended for first run

## Sponsors

- [DMARCTrust](https://www.dmarctrust.com)

## License

BSD 3-Clause License

Copyright (c) 2024-2025, VPS Armor Contributors

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
