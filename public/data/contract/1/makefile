all: msgola hello 
	@echo Rodando o programa  
	./hello

clean:
	rm HelloWorld.o hello
 
msgola:  
	@echo Bem vindo ao makefile. Vou tentar executar o programa. 
 
hello: HelloWorld.o 
	g++ -o hello HelloWorld.o 
 
HelloWorld.o:
	g++ -c src/HelloWorld.cpp 
