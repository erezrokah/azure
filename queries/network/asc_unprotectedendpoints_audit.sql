with network_sg as (
  select
    distinct name as sg_name
  from
    azure_network_security_group_security_rules
  where
    access = 'Allow'
    and direction = 'Inbound'
    and protocol in ('TCP','*')
    and source_address_prefixes in ('*', '0.0.0.0', '0.0.0.0/0', 'Internet', '<nw>/0', '/0')
)
select
  vm.vm_id,
  sub.display_name as subscription_name,
  sub.id as subscription_id
from
  azure_compute_virtual_machines as vm
  left join azure_network_security_groups as sg on sg.network_interfaces @> vm.network_interfaces
  join azure_subscription_subscriptions as sub on sub.subscription_id = vm.subscription_id
  where sg.sg_name is not null;