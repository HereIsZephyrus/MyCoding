#pragma once
#ifndef _ENUMS_H_
#define _ENUMS_H_
enum ButtonType {
	Load,
	Save,
	New,
	Open,
	Exit,
	Switch,
	DrawPoint,
	DrawLine,
	DrawPolygen,
	NOEXIST_BUTTON
};
enum Status
{
	Hold,
	Drawing,
	Drag,
	Clicking,
	NOEXIST_STATUS
};
enum Areas
{
	Toolbar,
	Photo,
	OUT_OF_RANGE
};
#endif // !_ENUMS_H_

