//
//  ViewController.m
//  SaltSideSample
//
//  Created by Ashish Kumar on 03/12/15.
//  Copyright © 2015 SS. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (nonatomic, strong)NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Feed";
    
    if (_dataArray.count == 0) {
        [_activityIndicator startAnimating];
        _feedTableView.hidden = true;
    }
    else{
        [_activityIndicator stopAnimating];
        _feedTableView.hidden = false;
    }
    [self downloadJson];
}


#pragma mark - API Call

-(void)downloadJson {
    
    NSURL *URL = [NSURL URLWithString:@"https://gist.githubusercontent.com/maclir/f715d78b49c3b4b3b77f/raw/8854ab2fe4cbe2a5919cea97d71b714ae5a4838d/items.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      // ...
                                      
                                      if (error == nil){
                                          NSError *jsonParseError;
                                          
                                          self.dataArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParseError];
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [_activityIndicator stopAnimating];
                                              _feedTableView.hidden = false;
                                              [self.feedTableView reloadData];
                                              
                                          });
                                      }
                                      
                                  }];
    
    [task resume];
    
}


#pragma Tableview Delegate and Datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = _dataArray[indexPath.row][@"title"];
    cell.detailTextLabel.text = _dataArray[indexPath.row][@"description"];
    cell.detailTextLabel.numberOfLines = 2;
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //detailViewContoller
    [self performSegueWithIdentifier: @"detailViewContoller" sender: self];

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if ([segue.identifier isEqualToString:@"detailViewContoller"]) {
        NSIndexPath *indexPath = [self.feedTableView indexPathForSelectedRow];
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.detailTitle = _dataArray[indexPath.row][@"title"];
        destViewController.detailDescription = _dataArray[indexPath.row][@"description"];
        destViewController.imageURL = _dataArray[indexPath.row][@"image"];

    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
