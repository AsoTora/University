#include <iostream>
#include <queue>

using namespace std;

/*
 А. Создать сбалансированное дерево поиска, состоящее из целых чисел.
Вывести информацию на экран, используя прямой, обратный и симметричный
обход дерева. Выполнить задание, результат вывести на экран. В конце рабо-
ты освободить всю динамически выделенную память.

А1. Найти количество листьев дерева.
А2. Найти количество узлов, имеющих только одного потомка слева.


 B. Создать сбалансированное дерево поиска, состоящее из целых чисел.
Вывести информацию на экран, используя прямой, обратный и симметричный
обход дерева. Выполнить задание, результат вывести на экран. В конце рабо-
ты освободить всю динамически выделенную память.

B1. Поменять местами узлы с минимальным и максимальным ключами в
левом поддереве.
B2. Поменять местами узел с максимальным ключом и узел, являющийся
корнем дерева.
*/

struct  node{
    double data;
    node *left = nullptr;
    node *right = nullptr;
};

class tree{
public:
    node *root;
    tree(){root = nullptr;};
    ~tree() = default;

    // basic
    void insert(double data);
    node *search(double data);

    // DFS -- поиск в глубину (Depth-first search) 
    void preorder(node *root);  // предварительный обход
    void reverseinorder(node *root);  // симметричный обход
    void postorder(node *root); // обход в обратном порядке
    void iterativePreorder(node *root);

    //BFS -- поиск в ширину (Breadth-first search)
    void levelorder(node *root);
};

// basic
void tree::insert(double data) {
    node *tmp = new node;
    tmp->data = data;

    if (root == nullptr){
        root = tmp; return;
    }
    node *curr = root, *parent;
    while(true) {
        parent = curr;

        if (data < parent->data) {  // left
            curr = curr->left;
            if (curr == nullptr) {
                parent->left = tmp;
                return;
            }
        } else { // right
            curr = curr->right;
            if (curr == nullptr) {
                parent->right = tmp;
                return;
            }
        }
    }
}
node *tree::search(double data) {
    int d = 0;
    if (root == nullptr)
        return nullptr;

    node *curr = root;
    while(curr->data != data){
        if (curr == nullptr){
            cout << "there is no such data" << endl; return nullptr;
        }

        if (curr->data > data){  // go left
            curr = curr->left;
        }else{
            curr = curr->right;
        }
        d++;
    }
    if (curr != nullptr)
        cout << curr->data << "'s depth is " << d << endl;
    return curr;
}

// DFS
void tree::preorder(node *root) {  // root -- left -- right
    if (root == nullptr)
        return;

    cout << root->data << " ";
    preorder(root->left);
    preorder(root->right);
}
void tree::reverseinorder(node *root) {  // left -- root -- right
    if (root == nullptr)
        return;

    preorder(root->left);
    cout << root->data << " ";
    preorder(root->right);
}
void tree::postorder(node *root) {  // left -- right -- root
    if (root == nullptr)
        return;

    preorder(root->left);
    preorder(root->right);
    cout << root->data << " ";
}


// BFS
void tree::levelorder(node *root) {
    if (root == nullptr){
        return;
    }
    queue<node *> q; // очередь
    q.push(root);

    while (!q.empty()){
        node* temp = q.front(); // первый элемент в очереди
        q.pop();  // Удаляем первый элемент в очереди
        cout << temp->data << " ";

        if ( temp->left != nullptr )
            q.push(temp->left);  // Вставляем  в очередь левого потомка

        if ( temp->right != nullptr )
            q.push(temp->right);  // Вставляем  в очередь правого потомка
    }
}
int main() {
    tree bt;

    bt.insert(5);
    bt.insert(2);
    bt.insert(3);
    bt.insert(4);
    bt.insert(1);
    bt.insert(6);
    bt.insert(7);
    bt.preorder(bt.root);
    cout << endl;
    bt.levelorder(bt.root);
    return 0;
}