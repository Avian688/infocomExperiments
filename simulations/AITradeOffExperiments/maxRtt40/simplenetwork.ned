package infocomexperiments.simulations.AITradeOffExperiments.maxRtt40;

@namespace(inet);

import inet.node.inet.StandardHost;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.Router;
import ned.DatarateChannel;
import ned.IBidirectionalChannel;
import inet.common.scenario.ScenarioManager;
network simplenetwork
{
    parameters:
        @display("bgb=512,395");
        int numberOfServers = default(1);
        int numberOfNormalFlows = default(1);
        int numberOfLongerFlows = default(0);
        int numberOfRouters = default(1);
    types:
        channel satLine1 extends DatarateChannel //look at 
        {
            delay = 1ms;
            datarate = 10Gbps;
        }
        channel satLine2 extends DatarateChannel //look at 
        {
            delay = 9.75ms;
            datarate = 10Gbps;
        }
        channel bottleneckline1 extends DatarateChannel
        {
            delay = 0.5ms;
            datarate = 1Gbps;  //125000 bytes BDP = 83 packets
        }
    submodules:
        client1: StandardHost {
            @display("p=96,179");
        }
        client2: StandardHost {
            @display("p=96,86");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=450,350");
        }
        server1: StandardHost {
            @display("p=438,86");
        }
        server2: StandardHost {
            @display("p=438,179");
        }
        router1: Router {
            @display("p=215,140");
        }
        router2: Router {
            @display("p=327,140");
        }
//        scenarioManager: ScenarioManager {
//            @display("p=100,300;is=s");
//        }
    connections:
        client1.pppg++ <--> satLine1 <--> router1.pppg++;
        client2.pppg++ <--> satLine2 <--> router1.pppg++;

        router1.pppg++ <--> bottleneckline1 <--> router2.pppg++;

        router2.pppg++ <--> satLine1 <--> server1.pppg++;
        router2.pppg++ <--> satLine2 <--> server2.pppg++;

}
