//
//  AboutUsViewController.m
//  CargoGuruViper
//
//  Created by Виктория on 06.06.16.
//  Copyright © 2016 Виктория. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *aboutUsText;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setTextByLanguage];
}

- (IBAction)actionToggleLeftDrawer:(id)sender {
    [[AppDelegate globalDelegate] toggleLeftDrawer:self animated:YES];
}

- (void)setTextByLanguage {
    NSInteger currentIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentIndexCountry"] integerValue];
    if (currentIndex == 0) {
        self.aboutLabel.text = @"О проекте";
        self.aboutUsText.text = @"Мы с гордостью представляем вам новейший сервис для онлайн-расчета перевозки груза Cargo.guru, призванный упростить и ускорить процедуру выбора транспортной компании для перевозки ваших товаров. Теперь вам не придется тратить ценное время на поиски подходящей ТК, которая максимально отвечает вашим ожиданиям. Используя удобный сервис Cargo.guru, вы сможете выбрать перевозчика и рассчитать стоимость перевозки груза по России за считанные минуты, тогда как на поиски выгодного варианта в интернете уйдет около часа.\n\nВ нашей базе состоят тысячи надежных перевозчиков, работающих на территории России и СНГ. Огромное количество населенных пунктов позволит вам составить четкий маршрут буквально за считанные минуты. Широкий выбор альтернативных вариантов с возможностью сравнения – это главное преимущество сервиса Cargo.guru, на котором вы сразу сможете узнать стоимость грузоперевозок по России и странам СНГ.\n\nВы можете пользоваться нашим сайтом одинаково комфортно, заходя на него с любого устройства, будь то рабочий компьютер или смартфон. Сайт Cargo.guru адаптирован для пользователей, есть приложение для телефонов и планшетов, которое работает как на OS Android, так и на iOS. Поэтому при использовании мобильных устройств у вас не возникнет трудностей с расчетом доставки груза транспортной компанией.\n\nВы можете подобрать идеальный вариант по цене, меняя желаемые транспортные средства и сроки доставки. При этом вам не придется тратить уйму времени на структурирование и анализ информации для расчета стоимости доставки разными транспортными компаниями: она будет предоставлена за секунды и оформлена в удобном для восприятия виде.\n\nCargo.guru поможет вам сделать правильный выбор ТК!";
    } else if (currentIndex == 1) {
        self.aboutLabel.text = @"關於該項目";
        self.aboutUsText.text = @"М我們很榮幸為您呈現最新的在線計算貨物運送Cargo.guru 的服務，服務旨在簡化和加快選擇一家合適的運輸公司之程序。現在，你不必再花費寶貴的時間在尋找最能滿足您期望的一家TC。使用便捷的Cargo.guru服務，你可以選擇運輸公司，並在幾分鐘之內計算貨物在俄羅斯運輸的費用，以往你可能需要大約一個小時在互聯網上搜索一個具有成本效益的選擇。\n\n我們的數據庫由數以千計在俄羅斯和獨聯體境內營運的可靠運輸公司組成。數量龐大的定居點讓你在短短幾分鐘之內定出清晰的路線。Cargo.guru服務的優點在於提供廣泛而不同類型的替代方案給你比較，在這裡你可以馬上找到在俄羅斯和獨聯體境內貨物運輸的成本。\n\n我們的網站適合任何設備上使用，無論是台式電腦還是智能手機也能友好地使用。人性化的Cargo.guru 網站提供在手機和平板電腦的應用程序，應用程序適合在操作系統Android和iOS上使用。因此，當你使用移動設備來計算運輸公司提供的貨遞費用時，你不會感到任何困難。\n\n您可以通過改變所需的車輛和交貨時間來選擇完美的價格。若你想計算由不同運輸公司來交付的成本時，在這種情況下，你不必花費大量的時間來構建和分析信息：可讀形式的信息將在幾秒鐘內呈現。\n\nCargo.guru將幫助您正確的選擇TC！";
    } else if (currentIndex == 2) {
        self.aboutLabel.text = @"About the project";
        self.aboutUsText.text = @"We are proud to present you the newest service for online calculation of cargo transportation Cargo.guru, designed to simplify and speed up the procedure for selecting a transportation company to transport your goods. Now you do not have to spend valuable time looking for a suitable TC that best meets your expectations. Using the convenient service Cargo.guru, you can choose the carrier and calculate the cost of cargo transportation in Russia within a few minutes, while the search for a cost-efficient option on the Internet will take about an hour.\n\nOur database consists of thousands of reliable carriers operating on the territory of Russia and CIS. A huge number of settlements will allow you to make a clear route within just a few minutes. A wide range of alternatives available for comparison is the main advantage of Cargo.guru service, where you can immediately find out the cost of cargo transportation in Russia and CIS countries.\n\nOur site is mobile-friendly so you can use on any device, whether it is a desktop computer or a smart phone. The website Cargo.guru is also user-friendly, so there's an app for mobile phones and tablets, which works both on OS Android and iOS. Therefore, when using mobile devices you will have no difficulties with the calculation of cargo delivery by the transportation company.\n\nYou can find the perfect price option by changing the desired vehicles and delivery times. In this case you do not have to spend a lot of time structuring and analyzing the information in order to calculate the cost of delivery by different transportation companies: the information will be provided in a readable form within seconds.\n\nCargo.guru will help you make the right choice of TC!";
    } else if (currentIndex == 3) {
        self.aboutLabel.text = @"Über das Projekt";
        self.aboutUsText.text = @"Wir sind stolz, Ihnen den neusten Service für die Berechnung der Frachtlieferung Cargo.guru zu präsentieren, konzipiert um die Länge der Zeit und Komplexität beim Aussuchen der richtigen Spedition zu verringern. Jetzt müssen Sie nicht wertvolle Zeit damit verbringen, nach der Spedition zu suchen, die Ihren ANforderungen entspricht. Wenn Sie den bequemen Service bei Cargo.guru nutzen, können Sie die richtige Spedition aussuchen und die Kosten für Frachtlieferungen un Russland innerhalb von wenigen Minuten berechnen, während die Suche im Internet nach einer Kosten effektiven Alternative ungefähr eine Stunde dauert.\n\nUnsere Datenbank besteht auf tausenden zuverlässigen Spediteuren, die auf dem Territorium Russlands und der GUS operieren. Eine riesige Anzahl an Städten erlaubt es Ihnen in nur wenigen Minuten eine klare Route zu definieren. Viele Alternativen zum Vergleich stehen zur Verfügung und ist der Hauptvorteil des Cargo.guru Services, bei dem Sie sofort die Kosten für die Frachtlieferung in Russland und GUS herausfinden können.\n\nUnsere Seite ist für Mobile Nutzer geeignet und kann auf jedem Gerät genutzt werden, unabhängig davon, ob es ein Desktop Computer oder Smartphone ist. Die Webseite Cargo.guru ist auch sehr benutzerfreundlich und hat eine app für handys und Tablets, die sowohl mit mit OS Android, als auch iOS funktionieren. Deshalb werden Sie keine Probleme mit mobilen Geräten haben, wenn Sie die Frachtlieferung einer Spedition berechnen.\n\nSie können die perfekte Preis Option wählen, indem SIe das gewünschte Fahrzeug und die Ankunftszeit wechseln. In diesem Fall müssen Sie nicht viel Zeit damit verbringen, die Informationen zu strukturieren und analysieren um die Kosten für verschiedene Spediteure zu berechnen. Diese Informationen werden leserlich innerhalb weniger Sekunden zur Verfügung stehen.\n\nCargo.guru wird Ihnen helfen, den richtigen Spediteur zu finden!";
        
    } else if (currentIndex == 4) {
        self.aboutLabel.text = @"À propos du projet";
        self.aboutUsText.text = @"Nous sommes fiers de vous présenter le nouveau service pour le calcul en ligne de Cargo.guru pour le transport de fret, conçu pour simplifier et accélérer la procédure de sélection d'une compagnie de transport pour le transport de vos marchandises. Maintenant, vous ne devez plus passer un temps précieux à la recherche d'un TC approprié qui répond le mieux à vos attentes. En utilisant le service pratique Cargo.guru, vous pouvez choisir le transporteur et calculer le coût du transport de fret en Russie en quelques minutes, alors que la recherche d'une option rentable sur Internet va prendre environ une heure.\n\nNotre base de données est constituée de milliers de transporteurs fiables opérant sur le territoire de la Russie et de la CEI. Un grand nombre de colonies va vous permettre de faire un itinéraire clair en seulement quelques minutes. Une large gamme de solutions de rechange disponibles aux fins de comparaison est le principal avantage du service Cargo.guru, où vous pouvez connaître immédiatement le coût du transport de marchandises en Russie et dans tout autre pays de la CEI.\n\nNotre site est mobile-friendly de sorte que vous pouvez l’utiliser sur tout appareil, que ce soit un ordinateur de bureau ou un téléphone intelligent. Le site Cargo.guru est aussi facile à utiliser, donc il y a une application pour les téléphones mobiles et les tablettes, qui fonctionne aussi bien sur OS Android et iOS. Par conséquent, lors de l'utilisation des appareils mobiles, vous n’aurez aucune difficulté avec le calcul de la livraison de marchandises par la société de transport.\n\nVous pouvez trouver l'option de prix parfait en changeant les véhicules souhaités et les délais de livraison. Dans ce cas, vous ne devez pas passer beaucoup de temps a structurer et analyser l'information afin de calculer le coût de la livraison par les différentes compagnies de transport: l'information sera fournie sous une forme lisible en quelques secondes.\n\nCargo-Guru vous aidera a faire le bon choix de compagnhie de transport.";
        
    }
}
@end
