WITH agent_installed_vm AS (
    SELECT DISTINCT
        virtual_machine_cq_id
    FROM
        azure_compute_virtual_machine_resources
    WHERE
        virtual_machine_extension_properties ->> 'publisher' = 'Microsoft.Azure.Monitoring.DependencyAgent'
        AND virtual_machine_extension_properties ->> 'type' = 'DependencyAgentLinux'
        AND virtual_machine_extension_properties ->> 'provisioningState' = 'Succeeded'
) SELECT
azure_compute_virtual_machines.vm_id AS vm_id,
azure_subscription_subscriptions.subscription_id,
azure_subscription_subscriptions.display_name AS subscription_name
FROM
	azure_compute_virtual_machines
	LEFT JOIN agent_installed_vm ON agent_installed_vm.virtual_machine_cq_id = azure_compute_virtual_machines.cq_id,
	azure_subscription_subscriptions
WHERE
	azure_subscription_subscriptions.subscription_id = azure_compute_virtual_machines.subscription_id
	AND azure_compute_virtual_machines.storage_profile -> 'osDisk' ->> 'osType' = 'Linux'
	AND agent_installed_vm.virtual_machine_cq_id IS NULL;
