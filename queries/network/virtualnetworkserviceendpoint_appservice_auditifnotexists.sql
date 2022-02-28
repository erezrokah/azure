select
  a.id,
  sub.display_name as subscription_name,
  sub.id as subscription_id
from
  azure_web_apps as a,
  azure_subscription_subscriptions as sub
where
  sub.subscription_id = a.subscription_id and
--   VNET missing
--   vnet_connection ->> 'properties' ->> 'vnetResourceId' is null;
