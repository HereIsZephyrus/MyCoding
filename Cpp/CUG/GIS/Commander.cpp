#include "Commander.h"

int Commander::getCommand()
{
	
	if (MouseHit()) {
		mouse = GetMouseMsg();
		switch (static_cast<int>(DictateArea(mouse)))
		{
		case static_cast<int>(Toolbar) : {

			break;
		}
		case static_cast<int>(Photo): {
			break;
		}
		default://out_of_range
			break;
		}
	}
	else {
		//failed
	}
	return 0;
}

Areas Commander::DictateArea(const MOUSEMSG& mouse)
{
	const int x = mouse.x, y = mouse.y;
	if (x&&y) {
		return Toolbar;
	}
	if (x&&y) {
		return Photo;
	}
	return OUT_OF_RANGE;
}
