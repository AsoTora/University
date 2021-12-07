from django.shortcuts import render

def index(request):
    return render(request, 'index.html', context={})

def page1(request):
    return render(request, 'p1.html', context={})
def page2(request):
    return render(request, 'p2.html', context={})
def page3(request):
    return render(request, 'p3.html', context={})
def page4(request):
    return render(request, 'p4.html', context={})
def page5(request):
    return render(request, 'p5.html', context={})