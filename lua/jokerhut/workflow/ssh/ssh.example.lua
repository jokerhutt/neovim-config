-- This file holds the example configuration for the ssh dashboard
-- Fill this out and put it in ssh.lua
return {
	hosts = {
		vm = {
			label = "Dev VM",
			alias = "yourvm",
			group = "dev",
		},

		homelab = {
			label = "Homelab",
			alias = "yourhomelab",
			group = "infra",
		},
	},
}
