-include .env

.PHONY: new_state deploy env test vrf consumer executed_vouchers

info: header

define HEADER    
                                                    
 ██████╗██╗   ██╗███████╗████████╗ ██████╗ ███╗   ███╗     ██████╗ ██████╗ ███╗   ██╗████████╗██████╗  █████╗  ██████╗████████╗███████╗
██╔════╝██║   ██║██╔════╝╚══██╔══╝██╔═══██╗████╗ ████║    ██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝
██║     ██║   ██║███████╗   ██║   ██║   ██║██╔████╔██║    ██║     ██║   ██║██╔██╗ ██║   ██║   ██████╔╝███████║██║        ██║   ███████╗
██║     ██║   ██║╚════██║   ██║   ██║   ██║██║╚██╔╝██║    ██║     ██║   ██║██║╚██╗██║   ██║   ██╔══██╗██╔══██║██║        ██║   ╚════██║
╚██████╗╚██████╔╝███████║   ██║   ╚██████╔╝██║ ╚═╝ ██║    ╚██████╗╚██████╔╝██║ ╚████║   ██║   ██║  ██║██║  ██║╚██████╗   ██║   ███████║
 ╚═════╝ ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚══════╝

endef

export HEADER

# DEFAULT VARIABLES
START_LOG = @echo "======================================================= START OF LOG ========================================================="
END_LOG = @echo "======================================================== END OF LOG =========================================================="

EXECUTED_VOUCHERS := script/ExecutedVouchers.s.sol --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast -v
DEPLOY_NETWORK_ARGS := script/DeployContracts.s.sol --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast -v
DEPLOY_COORDINATOR_VRF_ARGS := script/DeployVRFCoordinatorV2Mock.s.sol --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast -v >> vrf.txt
DEPLOY_CONSUMER_ARGS := script/DeployVRFConsumer.s.sol --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast -v > consumer.txt

define test_contracts
	$(START_LOG)
	@forge test
	$(END_LOG)
endef

define vrf
	$(START_LOG)
	@forge script $(DEPLOY_COORDINATOR_VRF_ARGS)
	$(END_LOG)
endef

define consumer
	$(START_LOG)
	@forge script $(DEPLOY_CONSUMER_ARGS)
	$(END_LOG)
endef

define executed_vouchers
	$(START_LOG)
	@forge script $(EXECUTED_VOUCHERS)
	$(END_LOG)
endef

define deploy_contracts
	$(START_LOG)
	@forge script $(DEPLOY_NETWORK_ARGS)
	$(END_LOG)
endef

setup: .env.tmpl
	forge install
	cp .env.tmpl .env

test:
	@echo "$$HEADER"
	@$(test_contracts)

new_state:
	@echo "$$HEADER"
	@$(executed_vouchers)

deploy:
	@echo "$$HEADER"
	@$(deploy_contracts)

vrf:
	@echo "$$HEADER"
	@$(vrf)

consumer:
	@echo "$$HEADER"
	@$(consumer)