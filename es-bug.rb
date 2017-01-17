require 'elasticsearch'

hosts = %w(1.2.3.4 5.6.7.8 9.10.11.12)
client = Elasticsearch::Client.new hosts: hosts, retry_on_failure: true, reload_connections: true, reload_on_failure: true, transport_options: { request: { open_timeout: 1, timeout: 1 } }
client.cluster.health
