default:
	python ./core/setup.py build_ext --inplace
	mv ./core/main.pyx ./core/dep/main.pyx
	python main.py
	mv ./core/dep/main.pyx ./core/main.pyx

