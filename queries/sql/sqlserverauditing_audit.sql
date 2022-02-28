select
  s.id,
  sub.display_name as subscription_name,
  sub.id as subscription_id
from
  azure_sql_servers s,
--   audit policy missing
--   jsonb_array_elements(server_audit_policy) audit,
  azure_subscription sub
where
  sub.subscription_id = s.subscription_id
--   and audit -> 'properties' ->> 'state' = 'Disabled';