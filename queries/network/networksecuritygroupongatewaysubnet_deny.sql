select
  subnet.id,
  sub.display_name as subscription_name,
  sub.id as subscription_id
from
  azure_network_virtual_network_subnets as subnet
  join azure_subscription_subscriptions as sub on sub.subscription_id = subnet.subscription_id
  where subnet.name = 'GatewaySubnet' and network_security_group_id is not null;