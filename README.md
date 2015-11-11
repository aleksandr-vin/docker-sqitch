# docker-sqitch

This repository contains Dockerfile of sqitch for Docker

Usage

    docker run -it --rm meticulo3366/docker-sqitch sqitch

Specific Example PostgreSQL

	**DB_USER** = database user
	**DB_NAME** = database name
	**DB_HOST**  = host server for postgres
	**DB_PORT** = database port

	docker run -it --rm meticulo3366/docker-sqitch sqitch deploy db:pg://${DB_USER}@${DB_HOST}:${DB_PORT}/${DB_NAME}

Specific Example mySQL

	**DB_USER** = database user
	**DB_NAME** = database name
	**DB_HOST**  = host server for postgres
	**DB_PORT** = database port

	docker run -it --rm meticulo3366/docker-sqitch sqitch deploy db:mysql://${DB_USER}@${DB_HOST}/${DB_NAME}