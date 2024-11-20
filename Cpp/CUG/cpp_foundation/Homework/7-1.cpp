#include<iostream>
#include<vector>

class List{
    private:
        struct Node{
            int data;
            Node* next;
            Node(int data, Node* next = nullptr){
                this->data = data;
                this->next = next;
            }
        };
        Node* head;
        Node* tail;
        int size;
    public:
        List(){
            head = nullptr;
            tail = nullptr;
            size = 0;
        }
        ~List(){
            while (head != nullptr){
                Node* temp = head;
                head = head->next;
                delete temp;
            }
        }
        void push_back(int data){
            if (head == nullptr){
                head = new Node(data);
                tail = head;
            }
            else{
                tail->next = new Node(data);
                tail = tail->next;
            }
            size++;
        }
        void push_front(int data){
            if (head == nullptr){
                head = new Node(data);
                tail = head;
            }
            else{
                head = new Node(data, head);
            }
            size++;
        }
        void pop(int num){
            Node* temp = head;
            while (temp != nullptr){
                if (temp->data == num){
                    if (temp == head){
                        head = head->next;
                        delete temp;
                        size--;
                        return;
                    }
                    else if (temp == tail){
                        tail = temp->next;
                        delete temp;
                        size--;
                        return;
                    }
                    else{
                        Node* temp2 = head;
                        while (temp2->next != temp){
                            temp2 = temp2->next;
                        }
                        temp2->next = temp->next;
                        delete temp;
                        size--;
                        return;
                    }
                }
                temp = temp->next;
            }
        }
        int front(){
            return head->data;
        }
        int back(){
            return tail->data;
        }
        int getSize(){
            return size;
        }
        void print(){
            Node* temp = head;
            std::vector<int> v;
            while (temp != nullptr){
                v.push_back(temp->data);
            //    std::cout << temp->data << " ";
                temp = temp->next;
            }
            //std::cout<< temp->data << std::endl;
            for (std::vector<int>::iterator it = v.end()-1; it != v.begin(); it--){
                std::cout << *it << " ";
            }
            std::cout << *v.begin() <<std::endl;
        }
};

List list;
int main(){
    int num{0};
    std::cin >> num;
    while (num != -1){
        list.push_back(num);
        std::cin >> num;
    }
    std::cin >> num;
    list.pop(num);
    list.print();
    std::cin.get();
    std::cin.get();
    return 0;
}