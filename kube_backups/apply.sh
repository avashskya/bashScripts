#!/bin/bash

for yaml in $(ls | grep -v apply.sh); do
	kubectl apply -f $yaml --validate=false
done

