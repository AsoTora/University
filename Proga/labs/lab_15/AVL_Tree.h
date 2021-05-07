//
// Created by aso on 3/20/19.
//

#ifndef LAB_15_AVL_TREE_H
#define LAB_15_AVL_TREE_H

struct  node{
    double data;
    node *left = nullptr;
    node *right = nullptr;
};

class avl_tree{
public:
    // main
    node *root;
    avl_tree(){root = nullptr;};
    ~avl_tree() = default;

    // operations
    node *insert(node*, double data);
    void del(double data);
    node *search(double data);
    void inorder(node *);
    void display(node *, int);

    //rotations
    node *rr_rotation(node *);
    node *ll_rotation(node *);

    //extra
    int height(node *);
    int diff(node *);
    int max(int, int);
};

#endif //LAB_15_AVL_TREE_H
