  // работа с двумерными массивами и указателями

  if (max_adress == min_adress)
        cout << endl << "hhhhhhhhhh!";

    cout << endl << "max el: " << max << ", max el adress: " << max_adress << endl;
    for (int i = 0; i < M; i++)
        cout << max_adress[i] << endl;

    cout <<  endl << "min el:" << min << ", min el adress: " << min_adress << endl;
    for (int i = 0; i < M; i++)
        cout << min_adress[i] << endl;

    cout << endl << "stuff: ";
    for (int i = 0; i < M; i++)
        cout << " " << max_adress[i]; // == *(max_adress + i) // одно и то же

    
    // Замена строк местами
    if (max_adress != min_adress){
        for (int i = 0; i < M; i++){
            int temp =  max_adress[i];
            *(max_adress+i) = *(min_adress+i);
            *(min_adress+i) = temp;
        }
    }else{ // максимальный и минимальный элемент в одной строке
        cout << endl << "Max and Min elements are in the same string!" << endl;
        return 1;
    }
