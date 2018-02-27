//
//  ViewController.m
//  test
//
//  Created by ligang on 2018/2/7.
//  Copyright © 2018年 LG. All rights reserved.
//

#import "ViewController.h"

struct  list_node
{
	int data ; //数据域，用于存储数据
	struct list_node *next ; //指针，可以用来访问节点数据，也可以遍历，指向下一个节点
};
typedef struct list_node list_single ;

@interface ViewController ()

@end
void quick_sort(int s[], int l, int r);

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// 1.寻找二叉树两个结点的最低共同父节点----------------------------------------------------
//	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Tree" ofType:@"plist"];
//	NSDictionary *tree = [[NSDictionary alloc] initWithContentsOfFile:filePath];
//	//要查找的第一个子节点
//	NSDictionary *first = @{
//							@"Left" : @{},
//							@"Right" : @{},
//							@"Value" : @(3)
//							};
//	//要查找的第二个子节点
//	NSDictionary *second = @{
//							@"Left" : @{},
//							@"Right" : @{},
//							@"Value" : @(4)
//							};
//	NSDictionary *result = [self FindFirstCommonParentNode:tree addFirst:first andSecond:second];
//	NSLog(@"result:%@", result[@"Value"]);
	
	// 2.快速排序----------------------------------------------------
	// OC实现
//	NSArray *arr = @[@(20),@(30),@(2),@(16),@(72),@(98),@(3),@(22),@(50),];
//	NSMutableArray *Marr = [NSMutableArray arrayWithArray:arr];
//	[self quickSort:Marr start:0 end:arr.count - 1];
//	for (NSInteger i = 0; i < arr.count; i++) {
//		NSLog(@"--%ld-- \n", (long)[Marr[i] integerValue]);
//	}
	// C实现
//	int arg[5] = {90,70,18,30,520};
//	quick_sort(arg, 0, 4);
	
	// 3.单向链表，单向链表逆序----------------------------------------------------
	list_single *p = creat_list();
	list_single *p2 = reverse_list(p);
	do {
		NSLog(@"--%d", p2 -> data);
		p2 = p2 -> next;
	} while (p2 -> next != nil);
}

/**
 创建一个链表节点
 */
list_single *create_list_node(int data)
{
	list_single *node = NULL ;
	node = (list_single *)malloc(sizeof(list_single));
	if(node == NULL){
		printf("malloc fair!\n");
	}
	memset(node,0,sizeof(list_single));
	node->data = data;
	node->next = NULL ;
	return node ;
}

/**
 创建一个链表
 */
list_single *creat_list()
{
	list_single *node1 = create_list_node(1);
	list_single *node2 = create_list_node(2);
	list_single *node3 = create_list_node(3);
	list_single *node4 = create_list_node(4);
	node1->next = node2;
	node2->next = node3;
	node3->next = node4;
	return node1;
}

/**
 链表逆序
 参考 http://blog.csdn.net/autumn20080101/article/details/7607148
 */
list_single * reverse_list(struct list_node *p)
{
	list_single *next;
	list_single *prev = nil;
	
	while (p != nil) {
		next = p -> next;
		p -> next = prev;
		prev = p;
		p = next;
	}
	return prev;
}

/*
 * 快速排序（C实现）
 1．i =L; j = R; 将基准数挖出形成第一个坑a[i]。
 2．j--由后向前找比它小的数，找到后挖出此数填前一个坑a[i]中。
 3．i++由前向后找比它大的数，找到后也挖出此数填到前一个坑a[j]中。
 4．再重复执行2，3二步，直到i==j，将基准数填入a[i]中。
 */
void quick_sort(int s[], int l, int r)
{
	if (l < r)
	{
		int i = l, j = r, x = s[l];
		// 1.用挖坑填数的方法，把小于x的数放在左边，把大于x的数放在右边，最后把x放在最后一个被遍历的位置
		while (i < j)
		{
			while(i < j && s[j] >= x) // 从右向左找第一个小于x的数
				j--;
			if(i < j)
				s[i++] = s[j];
			
			while(i < j && s[i] < x) // 从左向右找第一个大于等于x的数
				i++;
			if(i < j)
				s[j--] = s[i];
		}
		s[i] = x;
		// 2.用分治法，分别对x左边的数组和x右边的数组进行排序
		quick_sort(s, l, i - 1); // 递归调用
		quick_sort(s, i + 1, r);
	}
}

/*
 * 快速排序（OC实现）
 1．i =L; j = R; 将基准数挖出形成第一个坑a[i]。
 2．j--由后向前找比它小的数，找到后挖出此数填前一个坑a[i]中。
 3．i++由前向后找比它大的数，找到后也挖出此数填到前一个坑a[j]中。
 4．再重复执行2，3二步，直到i==j，将基准数填入a[i]中。
 */
- (void)quickSort:(NSMutableArray *)arr start:(NSInteger)start end:(NSInteger)end {
	if (!arr || arr.count <= 1 || start > end) {
		return;
	}
	NSInteger i = start, j = end, X = [arr[start] integerValue];
	while (i < j) {
		while (i < j && [arr[j] integerValue] >= X) {
			j--;
		}
		if (i < j) {
			arr[i] = arr[j];
			i++;
		}
		while (i < j && [arr[i] integerValue] < X) {
			i++;
		}
		if (i < j) {
			arr[j] = arr[i];
			j--;
		}
		
	}
	arr[i] = @(X);
	[self quickSort:arr start:start end:i -1];
	[self quickSort:arr start:i + 1 end:end];
}

/*
 *  寻找二叉树两个结点的最低共同父节点
 */
- (NSDictionary *)FindFirstCommonParentNode:(NSDictionary *)root
								   addFirst:(NSDictionary *)first
								  andSecond:(NSDictionary *)second {
	if (root == nil) {
		return nil;
	}
	if ([root[@"Value"] integerValue] == [first[@"Value"] integerValue]
		|| [root[@"Value"] integerValue] == [second[@"Value"] integerValue]) {
		return root;
	}
	// 递归遍历左子树
	NSDictionary *left = [self FindFirstCommonParentNode:root[@"Left"] addFirst:first andSecond:second];
	// 递归遍历右子树
	NSDictionary *right = [self FindFirstCommonParentNode:root[@"Right"] addFirst:first andSecond:second];
	
	if (!left) {
		// 1、左子树没有找到任何一个结点，则第一个公共父节点必定在右子树，而且找到第一个结点就是最低共同父节点
		return right;
	} else if (!right) {
		//2、右子树没有找到任何一个结点，则第一个公共父节点必定在左子树，而且找到第一个结点就是最低共同父节点
		return left;
	} else {
		//3、分别在结点的左右子树找到，则此节点必为第一个公共父节点
		return root;
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
