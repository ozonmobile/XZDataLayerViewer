//  Created by Andrey Ostanin on 06.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZViewerInterface.h"
#import "XZDataSourceProtocol.h"
#import "XZViewModel.h"
#import "XZDataSourceFabric.h"

@interface XZViewerInterface ()
@property(nonatomic,strong)id<XZDataSourceProtocol> dataSource;
@end

@implementation XZViewerInterface
- (instancetype)initWithDataSource:(id<XZDataSourceProtocol>)dataSource{
	self = [super initWithStyle:UITableViewStylePlain];
	if (self != nil) {
		_dataSource = dataSource;
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
	}
	return self;
}

- (void)viewDidLoad{
	[super viewDidLoad];
	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass(self.class)];
	}
	
	XZViewModel *viewModel = [self.dataSource viewModelForIndexPath:indexPath];
	if (viewModel == nil) {
		cell.textLabel.text = @"empty";
	} else if (viewModel.shouldShowDisclosureIndicator == YES) {
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		cell.textLabel.text = viewModel.key;
		cell.detailTextLabel.text = nil;
	} else if(viewModel.shouldShowDisclosureIndicator == NO){
		[cell setAccessoryType:UITableViewCellAccessoryNone];
		cell.textLabel.text = viewModel.key;
		cell.detailTextLabel.text = viewModel.value;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.row >= [self.dataSource count]) {
		return;
	}
	id rawData = [self.dataSource rawDataForIndexPath:indexPath];
	if (rawData == nil) {
		return;
	}
//	//TODO: DataSourceFabric is impilicit dependency
	id<XZDataSourceProtocol> dataSource = [XZDataSourceFabric dataSourceForData:rawData];
	if (dataSource == nil) {
		return;
	}
	[self.navigationController pushViewController:[[XZViewerInterface alloc] initWithDataSource:dataSource] animated:YES];
}

- (void)refresh{
	[self.tableView reloadData];
	[self.refreshControl endRefreshing];
}

- (void)dismiss{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
