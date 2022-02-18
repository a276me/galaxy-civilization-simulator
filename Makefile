default:
	python ./core/setup.py build_ext --inplace
	mv ./main.cpython-39-darwin.so ./core/main.cpython-39-darwin.so
	clear
	python main.py

win:
	python ./core/setup.py build_ext --inplace
	move ./main.cp39-win_amd64.pyd ./core/main.cp39-win_amd64.pyd
	cls
	python main.py

git:
	git add .
	git commit -m "just another commit"
	git push

