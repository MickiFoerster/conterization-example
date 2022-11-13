build:
	docker build -t app . 
run:
	docker run \
		-v devolume:/usr/local/cargo  \
		--rm  \
		-p 80:3000 \
		--env RUST_LOG=debug  \
		--name  myapp app 
kill:
	docker kill myapp
test-get:
	curl -v http://localhost/
test-post:
	curl -X POST -v -d '{"username":"john"}' \
		-H "Content-type: application/json" \
		http://localhost/users
