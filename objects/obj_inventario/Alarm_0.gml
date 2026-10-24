/// @description  Acelera el borrado de items

if (tirando) {
    timerAcelerador = timerAcelerador * 2;
    alarm[0] = SECOND;
} else {
    timerAcelerador = 1;
}


