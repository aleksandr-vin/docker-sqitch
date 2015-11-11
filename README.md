# docker-sqitch

This repository contains Dockerfile of sqitch for Docker

Usage

    docker run -it --rm meticulo3366/docker-sqitch sqitch

Specific Example PostgreSQL

	docker run -it --rm meticulo3366/docker-sqitch sqitch deploy db:pg://${DB_HOST}@${PGHOST}:${PGPORT}/${DB_NAME}