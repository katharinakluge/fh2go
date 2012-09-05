//
//  BrowserViewController.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 25/07/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "BrowserViewController.h"

@implementation BrowserViewController

@synthesize exportButton;
@synthesize toolbar = _toolbar;
@synthesize webView = _webView;
@synthesize URL = _URL;
@synthesize loadingActivity = _loadingActivity;
@synthesize refreshButton = _refreshButton;
@synthesize stopView = _stopView;
@synthesize refreshView = _refreshView;
@synthesize forwardButton = _forwardButton;
@synthesize backButton = _backButton;


- (IBAction)openPressed:(id)sender {
    // Show action sheet with option to open in safari
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Export" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Safari", nil];
    [actionSheet showFromBarButtonItem:self.exportButton animated:YES];
}

- (IBAction)reloadPressed:(id)sender {
    [_refreshButton setCustomView:_stopView];
    [_loadingActivity startAnimating];
    
    // Reloaded request
    if ([[_webView request] URL]==nil) {
        NSURLRequest *request = [NSURLRequest requestWithURL:_URL];
        [_webView loadRequest:request];
    }else {
        [_webView reload];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@""];
    
    // start loading the URL into the webview
    NSURLRequest *request = [NSURLRequest requestWithURL:_URL];
    [_webView loadRequest:request];
    
    // Style the toolbar
    _stopView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_stopView setImage:[UIImage imageNamed:@"StopIcon"] forState:UIControlStateNormal];
    [_stopView setFrame:CGRectMake(0, 0, 23, 24)];
    [_stopView addTarget:self action:@selector(stopLoading) forControlEvents:UIControlEventTouchUpInside];
    [_toolbar setBackgroundImage:[UIImage imageNamed:@"NavigationBar.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
}

- (void)stopLoading {
    // cancel all loadings
    [_webView stopLoading];
    [_refreshButton setCustomView:_refreshView];
    [_loadingActivity stopAnimating];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    // Update the title of the navigation controller with the title of the website
    NSString *title=[aWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [_refreshButton setCustomView:_refreshView];
    [self setTitle:title];
    [_loadingActivity stopAnimating];
    
    [_backButton setEnabled:[_webView canGoBack]];
    [_forwardButton setEnabled:[_webView canGoForward]];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [_refreshButton setCustomView:_stopView];
    [_loadingActivity startAnimating];
    
    [_backButton setEnabled:[_webView canGoBack]];
    [_forwardButton setEnabled:[_webView canGoForward]];
    return YES;   
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // open URL in safari
        [[UIApplication sharedApplication] openURL:_URL];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
