//
//  ViewController.m
//  LerJson
//
//  Created by Faculdade Alfa on 03/12/16.
//  Copyright (c) 2016 Avantagem. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tabela, listaDados, listaImagens;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)carregarDados {
    NSError *erro;
    @try {
        NSURL *url = [NSURL URLWithString:@"http://www.marcosdiasvendramini.com.br/Get/Estereogramas.aspx"];
        NSData *dados = [NSData dataWithContentsOfURL:url];
        listaDados = [NSJSONSerialization JSONObjectWithData:dados options:kNilOptions error:&erro];
        for (int cont = 0; cont < listaDados.count; cont++) {
            [listaImagens addObject:[UIImage imageNamed:@"imagem.png"]];
        }
        [tabela reloadData];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
