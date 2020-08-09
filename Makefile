init:
	cp backup.tf.bak backup.tf && \
	sed -i.bak -e "s/<project-name>/$(PROJECT_NAME)/g" backup.tf 
	sed -i '' -e "s/<profile>/$(AWS_PROFILE)/g" backup.tf