#include "Objects.h"
#include "Errors.h"
#include "Buttons.h"
#include "Commander.h"

void Initialize();
void ShutDown();
int main(int argc,char *argv[]) {
	Initialize();
	Commander cmder;
	while (cmder.getCommand()) {

	}
	ShutDown();
	return 0;
}

void Initialize() {
	initgraph(1280, 720);

	return;
}
void ShutDown() {
	closegraph();
	return;
}
