.PHONY: init
init:
	./scripts/init.sh

.PHONY: check
check:
	SKIP_WASM_BUILD=1 cargo check

.PHONY: test
test:
	SKIP_WASM_BUILD=1 cargo test --all

.PHONY: build
build:
	cargo build --release;

.PHONY: polkarun
polkarun:
	cargo build --release; ./polkadot/target/release/polkadot build-spec --chain rococo-local --raw --disable-default-bootnode > rococo_local.json; ./polkadot/target/release/polkadot --chain ./rococo_local.json -d cumulus_relay0 --validator --alice --port 50556 & sleep 10; ./polkadot/target/release/polkadot --chain ./rococo_local.json -d cumulus_relay1 --validator --bob --port 50555 & sleep 10; ./target/release/standard-collator -d local-test --collator --alice --ws-port 9945 --parachain-id 200 -- --chain ./rococo_local.json;

.PHONY: run1
run1:
	./target/release/opportunity-collator -d local-test --alice --ws-port 9945;

.PHONY: run2
run2:
	./target/release/opportunity-collator -d local-test --bob --ws-port 9946;