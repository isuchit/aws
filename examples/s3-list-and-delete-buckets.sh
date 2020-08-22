buckets=$(aws s3api list-buckets --query "Buckets[?contains(Name,'$1')].Name" --output text)
	# if [ ${buckets[@]} === "" ]; then
	# exit
	# fi
	echo "These buckets are going to be deleted....!!!!"
	for bucket in ${buckets[@]}
	do
			echo "$bucket"
		done
		read -r -p "Are you sure want to delete? [y/N] " response
		case "$response" in
			[yY][eE][sS]|[yY]) 
				for bucket in ${buckets[@]}
				do
					echo "Deleting $bucket...."
					aws s3 rb "s3://${bucket}" --force 2>&1 >/dev/null &&
					echo -e "Done" ||
					# If error logic here
					echo -e "Error"
				done
			    ;;
			*)
			    exit;
			    ;;
esac
