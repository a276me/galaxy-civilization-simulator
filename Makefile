default:
	python ./core/setup.py build_ext --inplace
	mv ./main.cpython-39-darwin.so ./core/main.cpython-39-darwin.so

	python main.py

git:
	git add .
	git commit -m "just another commit"
	git push

