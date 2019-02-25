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

    // Insert, Delete
    node *deletenode (node *root, double data);

    // extra
    node *min(node *root);
    node *max(node *root);

    // labs
    int A_1(node *root);
    int A_2(node *root);
    void B_1();
    void B_2();
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
        cout << endl << endl <<  curr->data << "'s depth is " << d << endl << endl;
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

// Delete
node *tree::deletenode(node *root, double data){
    if (root == nullptr) return nullptr;

    if(data > root->data){  // ищем справа
        root->right = deletenode(root->right, data);
    }else if(data < root->data){  // ищем слева
        root->left = deletenode(root->left, data);
    }else{  // нашли
        // case 1
        if (root->left == nullptr && root->right == nullptr){
            delete root;
            root = nullptr;
        }
        // case 2
        else if(root->left == nullptr && root->right != nullptr){
            node *tmp = root;
            root = root->right;
            delete tmp;
        }
        else if(root->left != nullptr && root->right == nullptr){
            node *tmp = root;
            root = root->left;
            delete tmp;
        }
        // case 3
        else{
            node *tmp = min(root->right);
            root->data = tmp->data;
            root->right = deletenode(root->right, tmp->data);
        }
    }
    return root;
}

// extra
node *tree::min(node *root) {
    while(root->left != nullptr) root = root->left;
    return root;
}
node *tree::max(node *root){
    while(root->right != nullptr) root = root->right;
    return root;
}

// labs
int tree::A_1(node *root) {
    if (root == nullptr){  // на случай пустого дерева
        return 0;
    }
    if(root->right == nullptr && root->left == nullptr){  // base case
        return 1;
    }
    return A_1(root->left) + A_1(root->right);
}
int tree::A_2(node *root) {
    if (root == nullptr){  // на случай пустого дерева
        return 0;
    }
    if(root->right == nullptr && root->left != nullptr){  // base case
        return 1;
    }
    return A_2(root->left) + A_2(root->right);
}

void tree::B_1() {  // TODO
    if (root == nullptr) return;
    node *min_prev = root->left, *max_prev = root->left;

    if (min_prev->left != nullptr)
        while(min_prev->left->left != nullptr) min_prev = min_prev->left;
    if (max_prev->right != nullptr)
        while(max_prev->right->right != nullptr) max_prev = max_prev->right;

    cout << endl << max_prev->data << " " << min_prev->data;

    // case 1
    if (max_prev == min_prev){
        node *tmp = max_prev->left;
        max_prev->left = max_prev->right;
        max_prev->right = tmp;
    }
    // case 2
    else if(max_prev->right == nullptr){

    }else if(min_prev->left == nullptr){

    }
}

void tree::B_2() {
    if (root == nullptr || (root->left == nullptr && root->right == nullptr)) return;
    node *max_parent = root;

    if (max_parent->right != nullptr)
        while(max_parent->right->right != nullptr) max_parent = max_parent->right;

    if (root != max_parent){
        max_parent->right->right = root->right;
        max_parent->right->left = root->left;
        node *tmp = root;

        root->left = nullptr;
        root->right = nullptr;

        root = max_parent->right;
        max_parent->right = tmp;
    }else{
        root->right->right = root;
        root->right->left =  root->left;

        root = root->right;

        root->right->right = nullptr;
        root->right->left = nullptr;

    }


    cout << endl << "Task B_2 completed" << endl;
}


int main() {
    tree bt;
/*  example tree:
              	5
			   / \
			  3   10
			 / \   \
			1   4   11
*/

    bt.insert(5);
    bt.insert(10);
    bt.insert(3);
    bt.insert(4);
    bt.insert(1);
    bt.insert(11);
    bt.preorder(bt.root);
    cout << endl;
    bt.levelorder(bt.root);
    cout << endl << bt.A_2(bt.root);
    bt.deletenode(bt.root, 10);
    bt.B_2();
    bt.levelorder(bt.root);
    return 0;
}