//
// Created by aso on 3/20/19.
//

#include "AVL_Tree.h"
#include <iostream>

/*
AVL tree -- сбалансированное BST, высота правого и левого подреберья всегда различается на 1

 - высота -- 1.440log(n) // N(h) = 1 + N(n-1) + N(n-2) => h ~ 1.440log(n) or h < 2log(n)
 - время вставки (на место) -- О(nlg(n))
 - время сортировки (inorder traversal) -- О(n)
 - время поиска -- O(lg(n))

sources:
 1) https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-006-introduction-to-algorithms-fall-2011/lecture-videos/MIT6_006F11_lec06.pdf
 2) https://pandia.ru/text/80/369/88749.php

*/

// see avl_tree class in an AVL_Tree.h file

int avl_tree::max(int a, int b){
    return (a > b)? a : b;
}
int avl_tree::height(node *temp){  // высота одного узла, рекурсивная
    int h = 0;
    if (temp != nullptr){
        int left_height = height(temp->left);
        int right_height = height(temp->right);
        int max_height = max(left_height, right_height);
        h = max_height + 1;
    }
    return h;
}
int avl_tree::diff(node *temp){  // проверка узла на нарушение правил
    int left_height = height(temp->left);
    int right_height = height(temp->right);
    int balance = left_height - right_height;
    return balance;
}

// Right- Right Rotation
node *avl_tree::rr_rotation(node *parent){  // parent -- узел, нарушающий условие
    node *tmp = parent->right;
    parent->right = tmp->left;
    tmp->left = parent;

    return tmp; // на его место встанет tmp
}

// Left- Left Rotation
node *avl_tree::ll_rotation(node *parent){
    node *temp = parent->left;
    parent->left = temp->right;
    temp->right = parent;

    return temp;
}

node *avl_tree::insert(node* root, double data) {
    if (root == nullptr){
        root = new node;
        root->data = data;
        return root;
    }
    else if (data < root->data){
        root->left = insert(root->left, data);
    }
    else if (data > root->data){
        root->right = insert(root->right, data);
    }else{
        std::cout << "Error. Probably existing data. Not possible!" << std::endl;
        return root;
    }

    // balance
    int bal_factor = diff(root);

    if (bal_factor > 1){ // перевес влево
        if (diff(root->left) > 0)
            root = ll_rotation(root); // узлы идут left-left (т.е. один за другим влево)
        else{
            root->left = rr_rotation(root->left);  // значит, справа и слева по 1 ноде, сначала 1 поворот, потом другой
            root = ll_rotation(root);
        }
    }else if (bal_factor < -1){  // перевес вправо
        if (diff(root->right) > 0){
            root->right = ll_rotation(root->right);
            root = rr_rotation(root); // узлы идут right-right (т.е. один за другим вправо)
        }
        else
            root = rr_rotation(root); // значит, справа и слева по 1 ноде, сначала 1 поворот, потом другой
    }

    return root;
}

void avl_tree::inorder(node *root) {
    if (root == nullptr)
        return;
    inorder(root->left);
    std::cout << root->data << " ";
    inorder(root->right);
}

void avl_tree::display(node *ptr, int level){
    if (ptr != nullptr){
        display(ptr->right, level + 1);

        std::cout << "\n";
        for (int i = 0; i < level && ptr != root; i++)
            std::cout << "      ";
        std::cout << ptr->data;

        display(ptr->left, level + 1);
    }
}

