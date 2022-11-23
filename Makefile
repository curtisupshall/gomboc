
.PHONY:
	dump clean

clean:
	rm -rf ./test ./train ./validate

dump:
	@mkdir -p test train validate
	@echo "Dumping test.tar..."
	@tar -xf test.tar -C ./test
	@printf "Done.\n\n"
	@echo "Dumping validate.tar..."
	@tar -xf validate.tar -C ./validate
	@printf "Done.\n\n"
	@echo "Dumping train.tar..."
	@tar -xf train.tar -C ./train
	@printf "Done.\n"

gomboc:
	docker-compose up
