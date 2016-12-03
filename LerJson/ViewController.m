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
    listaImagens = [[NSMutableArray alloc] init];
    [self performSelector:@selector(carregarDados) withObject:nil];
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

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listaDados.count;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *celula = [tableView   dequeueReusableCellWithIdentifier:@"Celula"];
    if  (celula == nil) {
        celula = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Celula"];
    }
    if ([listaDados objectAtIndex:indexPath.row]!= nil) {
        NSDictionary *dados = [listaDados objectAtIndex:indexPath.row];
        celula.textLabel.text = [dados objectForKey:@"nome"];
        celula.imageView.image = [listaImagens objectAtIndex:indexPath.row];
        celula.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        if (
            ([[dados objectForKey:@"img"] isEqualToString:@""] == false)
            &&
            ([[listaImagens objectAtIndex:indexPath.row] isEqual:[UIImage imageNamed:@"imagem.png"]])) {
            NSString *urlImagem = [NSString stringWithFormat:@"http://www.marcosdiasvendramini.com.br/imgEstereograma/m%@",[dados objectForKey:@"img"]];
            dispatch_queue_t downloadQueue = dispatch_queue_create("image downloader", NULL);
            dispatch_async(downloadQueue, ^{
                NSData *dataImg = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlImagem]];
                UIImage *imagem = [UIImage imageWithData:dataImg];
                if (imagem) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [listaImagens replaceObjectAtIndex:indexPath.row withObject:imagem];
                        celula.imageView.image  = imagem;
                        celula.imageView.contentMode = UIViewContentModeScaleAspectFit ;
                        [celula setNeedsLayout];
                    });
                }
            });
        }
    }
    
    return celula;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
