import random
from math import sqrt
import matplotlib.pyplot as plt
import matplotlib as mpl


def build_histogram(data_values, data_names, title):
    '''
    Функция для построения диаграм по массиву данных и их названию (data_names, string)
    '''
    dpi = 80
    fig = plt.figure(dpi=dpi, figsize=(512 / dpi, 384 / dpi))
    mpl.rcParams.update({'font.size': 10})

    plt.title(title)

    ax = plt.axes()
    ax.yaxis.grid(True, zorder=1)

    xs = range(len(data_names))
    plt.bar([x + 0.3 for x in xs], data_values,
            width=0.8, color='blue', alpha=0.8,
            zorder=2)
    plt.xticks(xs, data_names)

    fig.autofmt_xdate(rotation=25)

    plt.legend(loc='upper right')
    fig.show()


def grafic_raspr():
    '''
    Имитация любой случайной величины, распределенной по экспоненциальному закону
    '''
    r = random.random()
    x = None
    if (r >= 0) and (r < 0.1):
        x = (r + 0.1) / 0.01
    elif (r >= 0.1) and (r < 0.3):
        x = (r + 0.7) / 0.04
    elif (r >= 0.3) and (r < 1):
        x = (r + 1.45) / 0.07
    return x


def gauss(m, sigma):
    '''
    Имитация гауссовского распределения
    m -- математическое ожидание (среднее значение) ими- тируемой случайной величины
    sigma – ее стандартное отклонение
    '''
    k = 6
    rsum = 0
    for i in range(k):
        r = random.random()
        rsum = rsum + r
    x = m + sigma * sqrt(12 / k) * (rsum - k / 2)
    return x


def proverka_1():
    gran = [i for i in range(10, 36)]
    p = [0.01 for i in range(10)]+[0.04 for i in range(5)]+[0.07 for i in range(10)]
    k = 25
    n = 100000
    d = 1
    m = [0 for i in range(25)]
    f = [0 for i in range(25)]

    for i in range(n):
        x = grafic_raspr()
        for j in range(k):
            if (x > gran[j]) and x <= gran[j + 1]:
                m[j] += 1
    print("\nПроверка 1")
    for i in range(k):
        f[i] = m[i] / (n * d)
        print("diap", gran[i], "-", gran[i+1])
        print(f"m[{i}]=", m[i])
        print(f"f[{i}]=", f[i])
    # подсчет переменной хи-квадрат
    hi_kv = 0

    for i in range(k):
        hi_kv += (m[i] ^ 2) / (n * p[i])

    print("\nхи-квадрат", hi_kv)

    build_histogram(f, [str(i + 10) + " - " + str(i + 11) for i in range(25)], 'First Check')


def proverka_2():
    gran = [90, 100, 110, 120, 130, 140, 150]
    p = [0.0214, 0.136, 0.3413, 0.3413, 0.136, 0.0214]
    k = 6
    n = 5000
    d = 10
    m = [0 for i in range(6)]
    f = [0 for i in range(6)]

    for i in range(n):
        x = gauss(120, 10)
        for j in range(k):
            if (x > gran[j]) and x <= gran[j + 1]:
                m[j] += 1
    print("\nПроверка 2")

    for i in range(k):
        f[i] = m[i] / (n * d)
        print("diap", gran[i], "-", gran[i+1])
        print(f"m[{i}]=", m[i])
        print(f"f[{i}]=", f[i])
    # подсчет переменной хи-квадрат
    hi_kv = 0

    for i in range(k):
        hi_kv += pow(m[i], 2 / (n * p[i]))

    # hi_kv -= n
    print("\nхи-квадрат", hi_kv)
    build_histogram(f, [str(i) + " - " + str(i + 10) for i in range(90, 150, 10)], 'Second Check')


def proverka_3():
    gran = [40, 50, 60, 70, 80, 90, 100]
    p = [0.0214, 0.136, 0.3413, 0.3413, 0.136, 0.0214]
    k = 6
    n = 5000
    d = 10
    m = [0 for i in range(6)]
    f = [0 for i in range(6)]

    for i in range(n):
        x = gauss(70, 10)
        for j in range(k):
            if (x > gran[j]) and x <= gran[j + 1]:
                m[j] += 1
    print("\nПроверка 3")

    for i in range(k):
        f[i] = m[i] / (n * d)
        print("diap", gran[i], "-", gran[i+1])
        print(f"m[{i}]=", m[i])
        print(f"f[{i}]=", f[i])
        
    # подсчет переменной хи-квадрат
    hi_kv = 0

    for i in range(k):
        hi_kv += (m[i] ^ 2) / (n * p[i])

    print("\nхи-квадрат", hi_kv)
    build_histogram(f, [str(i) + " - " + str(i + 10) for i in range(40, 100, 10)], 'Third Check')


def raschet():
    razmer_partii = 5000
    m_och = 120
    m_per = 70
    sigma = 10 # 
    n = 2000
    kol = 0
    t00 = 0
    tp0 = 0
    for i in range(n):
        sumr1 = 0
        sumr2 = 0
        for j in range(6):
            r1 = random.random()
            r2 = random.random()
            sumr1 += r1
            sumr2 += r2

        o = m_och + sigma * sqrt(2) * (sumr1 - 3)
        p = m_per + sigma * sqrt(2) * (sumr2 - 3)

        # Доля примесей S-%
        r = random.random()
        if r < 0.1:
            S = (r + 0.1) / 0.01
        elif r < 0.3:
            S = (r + 0.7) / 0.04
        else:
            S = (r + 1.45) / 0.07
        t0 = razmer_partii / o
        ver = random.random()
        if (S > 20) and (ver < 0.7):
            kol += 1
            t0 += razmer_partii / o
        tp = (razmer_partii - S * razmer_partii / 100) / p
        # Общее время очистки
        t00 += t0
        # Общее время переработки
        tp0 += tp
        # Среднее время обработки одной партии
        t = tp0 / n + t00 / n
        print("\nСреднее время обработки одной партии", t, "часов")
        vrst = kol / n
        print("Вероятность того, что для партии потребуется повторная очистка =", vrst * 100, "%")


proverka_1()
proverka_2()
proverka_3()
raschet()
