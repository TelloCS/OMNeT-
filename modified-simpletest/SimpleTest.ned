package inet.examples.rip.simpletest;

import inet.common.misc.ThruputMeteringChannel;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.configurator.ipv6.Ipv6FlatNetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.StandardHost;
import inet.node.internetcloud.InternetCloud;
import inet.node.rip.RipRouter;


network SimpleTest
{
    parameters:
        @display("p=10,10;b=712,152;bgb=1087,559");
    types:
        channel C extends ThruputMeteringChannel
        {
            delay = 0.1us;
            datarate = 100Mbps;
            thruputDisplayFormat = "#N";
        }
    submodules:
        rtr: RoutingTableRecorder {
            @display("p=100,300;is=s");
        }
        H2: StandardHost {
            parameters:
                @display("p=250,200;i=device/laptop");
            gates:
                ethg[1];
        }
        H6: StandardHost {
            @display("p=1000,275");
            gates:
                ethg[1];
        }
        H4: StandardHost {
            @display("p=1000,114");
            gates:
                ethg[1];
        }
        N1: EthernetSwitch {
            parameters:
                @display("p=400,200");
            gates:
                ethg[4];
        }
        R1: RipRouter {
            parameters:
                @display("p=550,200");
            gates:
                ethg[4];
        }
        R2: RipRouter {
            parameters:
                @display("p=700,200");
            gates:
                ethg[4];
        }
        N2: EthernetSwitch {
            parameters:
                @display("p=850,200");
            gates:
                ethg[4];
        }
        H5: StandardHost {
            parameters:
                @display("p=1000,200");
            gates:
                ethg[1];
        }
        H1: StandardHost {
            @display("p=250,114;i=device/laptop");
            gates:
                ethg[1];
        }
        H3: StandardHost {
            @display("p=250,269;i=device/laptop");
            gates:
                ethg[1];
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                config = xml("<config>"+
                            "<interface among='H1 H2 H3 R1' address='192.168.1.x' netmask='255.255.255.0' />"+
                            "<interface among='H4 H5 H6 R2' address='192.168.2.x' netmask='255.255.255.0' />"+
                            "<interface among='H7 H8 RC' address='192.168.3.x' netmask='255.255.255.0' />"+
                            "<interface among='H9 H10 RD' address='192.168.4.x' netmask='255.255.255.0' />"+
                            "<interface among='R1 R2' address='192.168.10.x' netmask='255.255.255.0' />"+
                            "<interface among='R1 RC' address='192.168.20.x' netmask='255.255.255.0' />"+
                            "<interface among='R1 RA' address='192.168.30.x' netmask='255.255.255.0' />"+
                            "<interface among='RC RD' address='192.168.40.x' netmask='255.255.255.0' />"+
                            "<interface among='R2 RD' address='192.168.50.x' netmask='255.255.255.0' />"+
                            "<interface among='R2 RB' address='192.168.70.x' netmask='255.255.255.0' />"+
                            "<interface among='RB RA' address='192.168.80.x' netmask='255.255.255.0' />"+
                            "<route hosts='H1 H2' destination='*' netmask='0.0.0.0' interface='eth0' />"+
                            "</config>");
                addStaticRoutes = false;
                addDefaultRoutes = false;
                @display("p=100,100;is=s");
        }
        configurator6: Ipv6FlatNetworkConfigurator {
            @display("p=100,200;is=s");
        }
        RA: RipRouter {
            @display("p=550,114");
            gates:
                ethg[2];
        }
        RB: RipRouter {
            @display("p=700,114");
            gates:
                ethg[2];
        }
        RC: RipRouter {
            @display("p=550,275");
            gates:
                ethg[3];
        }
        RD: RipRouter {
            @display("p=700,275");
            gates:
                ethg[3];
        }
        N3: EthernetSwitch {
            @display("p=550,399");
            gates:
                ethg[3];
        }
        N4: EthernetSwitch {
            @display("p=700,399");
            gates:
                ethg[3];
        }
        H7: StandardHost {
            @display("p=400,400");
            gates:
                ethg[1];
        }
        H8: StandardHost {
            @display("p=400,463");
            gates:
                ethg[1];
        }
        H9: StandardHost {
            @display("p=850,463");
            gates:
                ethg[1];
        }
        H10: StandardHost {
            @display("p=850,400");
            gates:
                ethg[1];
        }
    connections:
        H1.ethg[0] <--> C <--> N1.ethg[0];
        H2.ethg[0] <--> C <--> N1.ethg[1];
        H3.ethg[0] <--> C <--> N1.ethg[2];
        N1.ethg[3] <--> C <--> R1.ethg[0];

        R1.ethg[1] <--> C <--> R2.ethg[0];
        R1.ethg[2] <--> C <--> RA.ethg[0];
        R1.ethg[3] <--> C <--> RC.ethg[0];

        RA.ethg[1] <--> C <--> RB.ethg[1];
        RC.ethg[1] <--> C <--> RD.ethg[1];

        R2.ethg[3] <--> C <--> RB.ethg[0];
        R2.ethg[2] <--> C <--> RD.ethg[0];
        R2.ethg[1] <--> C <--> N2.ethg[3];

        N2.ethg[0] <--> C <--> H4.ethg[0];
        N2.ethg[1] <--> C <--> H5.ethg[0];
        N2.ethg[2] <--> C <--> H6.ethg[0];

        N3.ethg[0] <--> C <--> RC.ethg[2];
        N4.ethg[0] <--> C <--> RD.ethg[2];
        
       	N3.ethg[1] <--> C <--> H7.ethg[0];
   		N3.ethg[2] <--> C <--> H8.ethg[0];
   		
   		N4.ethg[1] <--> C <--> H9.ethg[0];
   		N4.ethg[2] <--> C <--> H10.ethg[0];
}

