# knife-glesys

## Installation

Add this line to your application's Gemfile:

    $ gem install knife-glesys

## Usage

### Create a new server

    $ knife glesys server create (options)

#### Options

`-t, --template TEMPLATE`        -  One of the available Glesys templates
`-p, --platform PLATFORM`        -  OpenVZ or Xen
`-d, --datacenter DATACENTER`    -  Location, (Falkenberg, New York, Amsterdam or Stockholm)
`-c, --cpucores CPUCORES`        -  Number of cpu cores (1-8)
`-m, --memory MEMORY`            -  The amount of memory (128mb-16384mb)
`-t, --transfer TRANSFER`        -  The amount of monthly transfer (50gb-10000gb)
`-N, --node-name NAME`           -  Chef node name
`-r, --run-list RUN_LIST`        -  Comma sperated list of roles/recipes tp apply
`-j, --json-attributes JSON`     -  A JSON string to be added to the first run of chef-client
`-R, --root-password PASSWORD`   -  Password to set on the root user
`-h, --hostname HOSTNAME`        -  Hostname to assign the server
`-d, --description DESCRIPTION`  -  Description of the server
`-i, --ipv4 IPV4`                -  IPv4 address to assign
`-I, --ipv6 IPV6`                -  IPv6 address to assign

#### Example

To create a Debian server in Stockholm.

    $ knife glesys server create -t "Debian 6.0 64-bit" -p OpenVZ -d Stockholm -c 1 -m 128 \
      -t 50 -N database -r 'role[:db]' -h db01.internet.com -R passw0rd -d 'Redis database server 01'


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
