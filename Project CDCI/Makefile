hello:
	echo "this is my first command"
install: 
	pip3 install --upgrade pip &&\
		pip3 install -r requirements.txt 
lint:
	pylint --disable =R,C,E1120,W0613 Click.py
test: 
	python3 -m pytest -vv click_test.py