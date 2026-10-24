/// @description chequeamos si ya nos podemos remover
// You can write your code in this editor
if (inmovilizado || paralizado) {
	if (current_time > inicioParalisis + duracionParalisis*1000){
		alarm[4] = 1
	}
}

alarm[10] = 30 